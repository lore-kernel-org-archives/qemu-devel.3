Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087E1CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifP-0003q8-8w; Fri, 19 Jun 2026 19:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifM-0003nw-2O
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifK-0007Pv-3e
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY6MI4085475
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=; b=T2xWqmonRaVmsSMt
 ZE+9CaZjOzuAByuTIJIE4kCTgeTtZy0kCeJIJcPFY7Xzkcj8tPC8rHDPbmM8xd1o
 uU5E30l4s6jLzMICx8MAnfc0DeRfVjQQU5PbwM0bAWPNpzufmDk9Yq1J0aeq/pa5
 BbKfj+5REvBSJaLPn7kFWeP4P4vTHSC8IGQ7AjHXa+LcTH6QyYinakdBfYnFsVDt
 mjG8AQZmsvtIATE5trkV8JpnXSF8c3Y6GgCOXJP3qdyBV3So0t6V3tJbyRTUASXT
 z8R+wZ1xxESVUMPrC8Bkji0ivqDZfUkzhNkkkdhIANICpeENXzgeYWAbTLk6fmi3
 SC8yIw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmyrdm93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0f4950ceso1010025eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911824; x=1782516624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=AxEL9lKb0f/l26QHoNI9ix/nECn4T8WEHbuDxf19asxOQ5CgVHdEBu8wu2/ashxtpN
 aYnUbMxHOyNaaOcnppUiYGkhimXkz3iyUHgL0GiAt/likuTijo2syx8/YSS6RPa/3VHo
 YuVQ8c+a+JUbESfY/z01XWNCPWCHCCqthw6rxnnHBm0LzxkggQc8JBGek9d3qyz7JgV4
 PY8XAMuuuBS/mK/faYjM6pTP1EbozaFaCwrui/Y0+T3D+FvUH2KhBP7VB2w2bQ7n0Jtw
 g+sxH7YIAOcNC0agoSdRq7018KRZGttwcxz1oeW+yfnPCcIdyGEaOhNW/8QNMxdOXjVO
 jD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911824; x=1782516624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X05v3GkLKVJ5oepV5+STkOz6Fp+VxO6RAfpTWbT6B70=;
 b=M+i1+gdRpRMs+qpOHj+Co1sJfhsnADDOjNY7L81jRfkPY2nWW0EU6eArAgRei/X/WJ
 9kMi5F41ddc6B7H25OKcaSL7AxLprhAyXorJTu+7DM7VCoB6ClvgUZq0d/UURAdPnW5t
 ALPjdLVQsdMPw/fAMolyKafJTq7sRevF77MC/We8aP5lAf9HFiyH0aoHkoDuzojK2aHy
 Gch+sbwt7LK3rR7GKaNL+nppyR7Dp2tNTP29VjqZBTMo2+p44fJIE4kQcxFh9B/4e1vN
 Ho9UBuYxfKqmX+mlunWVCUitSDpEjdUToCttwU1I6U202hlDGOKKNoNDAYuWTrf9LSMh
 ndQw==
X-Gm-Message-State: AOJu0Yx5bAyxBq/GUIdh96u4f54oOV2bVPXckrir8od3gi8llmpnqXzJ
 5yXOORwggnqviNUfdzLHmLNSkpoPgxTLBg41As8z39LdJe/yR1qtMDPgtt+idFLkYUgNXSkRRuS
 NIJCsUR/MdDStXj7/ITWqPndXjhsmbPEIeJFhpEyO0jlF0aYzRaWO61GJdmUCEZ1JcQ==
X-Gm-Gg: AfdE7clqgwl1P80tUoEcPGcAUBZqero0T7rHsFfQKDQf2ijxg+WJQmBskA+taGc5r7C
 eWAACsXGWyJ4N6/5SYuUsRPaWULn7G3R5ogyIYfWTTWDh2A3BA79KvQyV/lcGbkYHE8KUyUrFxy
 2cnzSCcjQzpU9BeTJUauh0mH3vWCtdn+1n9NIf21Z3X5eP2uNImeAXhw5/QBjqRTIzxDFHwjBB8
 rVONstb/1t2SMsLuKgF8o17vgni3CP8v7GHY5rDbSWTBJE6q6T84i1wwCXrWpDp6Rbr2tuON2AZ
 urgKCy2n3Xk7u9oCDE5Hsjal2AXlcoAPDfDwMDzIBoYD7pPTS94Un39dSTl3ddeW9rnFCtFD2MP
 1XJoit/hVumX7EoyuvN6oF9ADEgwNee9B2ecjshdXNuSCYtHVtwW52afgflI=
X-Received: by 2002:a05:7301:4b01:b0:30b:eb26:7330 with SMTP id
 5a478bee46e88-30c06807dafmr3487688eec.0.1781911823717; 
 Fri, 19 Jun 2026 16:30:23 -0700 (PDT)
X-Received: by 2002:a05:7301:4b01:b0:30b:eb26:7330 with SMTP id
 5a478bee46e88-30c06807dafmr3487671eec.0.1781911823214; 
 Fri, 19 Jun 2026 16:30:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 47/74] target/hexagon: add simple cpu_exec_reset and
 pointer_wrap
Date: Fri, 19 Jun 2026 15:58:44 -0700
Message-Id: <20260619225911.159473-48-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RZWgzVtv c=1 sm=1 tr=0 ts=6a35d110 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=O9wV_FzQyngHLK0UYg8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: sXXst0VppW0Ca6r4U4l6OVXwQTS0nL60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX618ny6QReZjg
 5Q11XRKeMdfx36ShqYXhL39B2SH883j5NrAsO8ts0PRkBiJDELha1Y6pAsq059wvpArB5YSUWTq
 oXSlRlE1A9C4AdCppxaPY88Bcih74/qzwP88sNWOcJDGTleGa2iLDrL6errAXFluML0oNNk/VeH
 n42XZyS8hdhuKVJ/IqfmHYl3jz2h4+S08q9ZnpkIwkVudS/wONUTiAC95PonnrdPLyvcbT4HHjR
 NQqFzkK6h36e1IvTIUNADQf/Y0utkxXpfVBl+3AfpAMKWVQDpY/9mqQMSX2aVl6q7o+64pbaNgs
 V//YF48TZWY+ebvQpkrcAnSNNaEp3AKoT9DruTiC3mquU8FFLfdAmow4fINpG3INHWWBuhIkZQZ
 aO+JiYDMyMMHBINCtw4Wqm/7LBwEtPxhbwpOyzzve5zLTU9JP0Mxi5xDd8t/RxZipkjtixqIm1a
 n/DGJOGQqzW2CA4gqUg==
X-Proofpoint-GUID: sXXst0VppW0Ca6r4U4l6OVXwQTS0nL60
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX+CYmLAw9yl6p
 B5N+V4lvDkMirIAv9Cga/MQ5PauzNaXH+eZBR3o62XV5lk340zup0Z8hR1zY5uK+X0p5aC5OOUn
 Egi7UDQxqICdnR2bh6arJNDA4Ypi8Qs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8g
PG1hdGhldXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXgg
MGQ2NTUxZGQ1YjYuLmVkZGU0YjFkYjg0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUu
YworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDk1LDYgKzQ5NSwxMiBAQCBzdGF0aWMg
Ym9vbCBoZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdChDUFVTdGF0ZSAqY3MsIGludCBpbnRlcnJ1
cHRfcmVxdWVzdCkKICAgICByZXR1cm4gZmFsc2U7CiB9CiAKK3N0YXRpYyB2YWRkciBoZXhhZ29u
X3BvaW50ZXJfd3JhcChDUFVTdGF0ZSAqY3MsIGludCBtbXVfaWR4LAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZhZGRyIHJlc3VsdCwgdmFkZHIgYmFzZSkKK3sKKyAgICByZXR1
cm4gcmVzdWx0OworfQorCiAjZW5kaWYKIAogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29u
X3RjZ19vcHMgPSB7CkBAIC01MDksNiArNTE1LDggQEAgc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBo
ZXhhZ29uX3RjZ19vcHMgPSB7CiAgICAgLm1tdV9pbmRleCA9IGhleGFnb25fY3B1X21tdV9pbmRl
eCwKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIC5jcHVfZXhlY19pbnRlcnJ1cHQgPSBo
ZXhhZ29uX2NwdV9leGVjX2ludGVycnVwdCwKKyAgICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9w
b2ludGVyX3dyYXAsCisgICAgLmNwdV9leGVjX3Jlc2V0ID0gY3B1X3Jlc2V0LAogI2VuZGlmIC8q
ICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCi0tIAoyLjM0LjEKCg==

