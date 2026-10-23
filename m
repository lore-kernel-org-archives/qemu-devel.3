Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2A606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RPSWwwml;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bz049rh4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4Sn-0005Xz-CH; Thu, 22 Oct 2026 21:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Ro-0002YC-Rc
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4Rn-0006Qj-2u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EtVG2389432
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=; b=RPSWwwmlecY8Q3C0
 Wcab1sjEgFEwYG5aPEl141DBz2FZoKiX0wdCObFpvjj7CSmav0JmxUAp0rXyc+hS
 f0T1lR1rDCiTDY/NrHusiAPjxzwFHVm8HNs3e/ldJ+vJNoPuZDut/s+I/PoFdef5
 4IHUX0Fo3dnr7vTzZTkVuE+fd6zwD/X497+cGZFcFGo7o6UtfD6U/Os1AUiGBGGI
 ix2CcQmcfzpqO4Q0g4iSIZZUoTEyH/arqHk3d2yKiAyUSO1485IeIulnz6uMVR6b
 vwsts9r9ovxx2Wc1iFO7k7bBswUDzGgB9DbVnJr6s4SN2NUYWpCd/Mfl04YQ1UXA
 kzMBzA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp9c9q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so550285eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720303; x=1793325103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=Bz049rh4N0/dPfDEZwTFxG1oCqTzHpkpzKfJEAwfCEjtoPug1OzwvM5PKv5snm2WYX
 QeZjye2hGYtkckkjaAA8KXrUW2McD0aIYcA1VsaBIj5/RD7Z6A/ncujIjTUt7ORJqzdz
 ZL1C3QGaSce85VxHpbtsgjgwKJ3q/GmyaFSJDR0O3leP/jVa7WxRy64q6tVGrcqrYAL1
 r2PlcAXXwxqD8ZiMneaIvGWTpDeT+FwK5DQn8faxMQiCRTGeOzVGpoH0RTa6RHkxipqL
 gWYgAWqUFeqJYc0mNxqRtouU6GS1x7xvk/XgRX3s62/GwzH+9D05D1k0M6iMjtKDr9bM
 6XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720303; x=1793325103;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MKY6BETE6+PZ+GNF6DoN62ECgJ9+7Stw1LUJ9DweSRA=;
 b=nxbrMEMCFMCw1AGmRUPv15iePoMRior0g6R5QiQf0HONTlL2PSONOvDAu1U+fiDSGU
 n+QZng8XWKOWFec/FMpjUMkPWwQi1qWA1bI6eu05LNhXShI4ksisnEVo7Qh4WdzAYLv6
 7JPNE7rlVd6RJ8YNDHWMC5sWwi9JQX+iXzWLqvIP1K++/sPZidLYqZXwenvBB/0CsVG6
 RWqqBqnUl9DcS0kRZbAJrEFza0W+VlNANqSz0WOjMJfdpIDdQQeCRQLMzbhewj6gsdFv
 9lMtHSPo9o4wu3DF5zdMV0DJQxyjp/QuG89b3LjjI8p5xT8FwPrtOI/AxCnb5cmYtyHj
 VkOg==
X-Gm-Message-State: AFq9FYLT0FljznAaRlyVce9eDGTUXtzQkhZxVtbNQep74VHoTkvrGlUo
 DRCWMwAl/qAr+0V9Y9R0MSoqV2fipg51u1HAi9XI9zFdPF6412DPigxajNJUOJUs0v7L9bMQar7
 +RYOJoR/0a3p2b3VdznTaYroEBSMItuWdfvpc07oZuA8ltcBySYp6ddErLryKbvc4tQ==
X-Gm-Gg: AYBFou0kYWVxjH3KSMc9ConihtXfE7IllWXX8pm7m41TwMBFYADAOcZqZodPF77JxPY
 vcIztVLKl5ysIIFfADELxacr7YwGVT/Exl/qkCsQrDlEsPQbP8Dbi8BoAXhg9l9Y0I3vZOGsC6N
 R+6pD23Cp0Ve9lFBUxYIZK5D1JVp9kXUVTMdigT/xR79duuG00dWak9/qjsJeyVZKvVNm/FNkib
 2jn7tE7+9yGxTnzck9j0EfGOjv3fd+mGsoOJ24JKas375luHQx8LnJUR7u/wSC6FjQIePVyT51K
 b9tNr7RBEVt+moadM2rakb3eamn4g+TPjI7VT0TSlAzspGU/tRhyDPFxkN/Us9dAuDTHJYMHeB2
 B0eqCp+jpTQE3/kGE+weGOULRGy6cTRDbww2KgVbQRGKdg6UE
X-Received: by 2002:a05:693c:8801:20b0:35c:e696:2d4a with SMTP id
 5a478bee46e88-369d9851d1amr992904eec.24.1792720303035; 
 Thu, 22 Oct 2026 18:51:43 -0700 (PDT)
X-Received: by 2002:a05:693c:8801:20b0:35c:e696:2d4a with SMTP id
 5a478bee46e88-369d9851d1amr992880eec.24.1792720302442; 
 Thu, 22 Oct 2026 18:51:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:41 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 36/43] target/hexagon: reset implicit USR write state
Date: Thu, 22 Oct 2026 18:50:33 -0700
Message-Id: <20261023015040.2473105-37-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXwK+RUwiIXgfi
 5LFwT6xy4RplEbbgP158tobfZXU89f6OZ74MG6BtqAW1kF6cTbq1m9MCIWYdfMRCyEZ7csLiAQR
 QggR3BSQ6rA6DoZRTNKUot9uKDlhPsE=
X-Proofpoint-GUID: NdzMydqWBg3zq-5Czs7Kk_-kmv3ZEOiF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX3LiekrU2mbHq
 cHwe/cHrPTgyRnHvRiI6divVpeL4cFva5+7CaDSoAk7JrsMR6b7+qNFAOsx7f3iaATn3XEnKBiu
 SFIJDZoArKBncY3pYGh464FaagKuTB2oPLBNMHk6BVipbcy9o/m6P3k7IWoflXAuV25jdVrLCd0
 oiiCkkcTUGmOzdBxvGn3uzk4xHZsVsH0dETA0e82zRSVh9y1Ux1dKmLcYXyvxng3cecJWGdIeuj
 pKQDnzkf13dbuf0XbUm9ct0OYLkFZl+Sk8rWtmDnJPm8mOR2/S8glLHQZFSjICR7WUrjLO7VsMs
 Tf617xeWdxJHXNNQ0PMql/dfqnKSEfibUudpPc05fnr8C+1/DPUppTbNJ0y7CbQMYasX5srT/Tl
 UEo0OVmVL16l01oX4hiukLpjqJ937wWN3GHJmO79QjeFWjCUoyNacz0EtBKu+N0OJbcaz7BjyTp
 zBUoVqarpP9KEzzGdlg==
X-Proofpoint-ORIG-GUID: NdzMydqWBg3zq-5Czs7Kk_-kmv3ZEOiF
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6adabdaf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6XX9eVd8KyvID48HtZQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230007
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aW1wbGljaXRfdXNyX3dyaXRlIGlzIHBlci1wYWNrZXQgREMgc3RhdGUuIEl0IHdhcyBub3QgY2xl
YXJlZCBiZWZvcmUKYW5hbHl6aW5nIHRoZSBuZXh0IHBhY2tldC4gUmVzZXQgaXQgdG9nZXRoZXIg
d2l0aCB0aGUgb3RoZXIgcGVyLXBhY2tldApzdGF0ZS4KCldoZW4gcnVubmluZyBxZmxvYXRfdjgx
IHVic2FuIHJlcG9ydGVkOgoKICAgIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jOjcyNTozMjog
cnVudGltZSBlcnJvcjogbG9hZCBvZiB2YWx1ZSAxOTIsCiAgICB3aGljaCBpcyBub3QgYSB2YWxp
ZCB2YWx1ZSBmb3IgdHlwZSAnX0Jvb2wnCiAgICB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYzo4
NzQ6MTI6IHJ1bnRpbWUgZXJyb3I6IGxvYWQgb2YgdmFsdWUgMTkyLAogICAgd2hpY2ggaXMgbm90
IGEgdmFsaWQgdmFsdWUgZm9yIHR5cGUgJ19Cb29sJwoKRml4ZXM6IDNlOTg0OTY2OTFlZCAoIkhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBJbXBsaWNpdCB3cml0ZXMgdG8gVVNSIGRvbid0IGZvcmNl
IHBhY2tldCBjb21taXQiKQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXgg
YWMwOGViOTFiOTYuLjA2YTNlZDU2OTYxIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFu
c2xhdGUuYworKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtNjQ5LDYgKzY0OSw3
IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3BrdF9jdHgoRGlzYXNDb250ZXh0ICpjdHgpCiAgICAgY3R4
LT5yZWdfbG9nX2lkeCA9IDA7CiAgICAgYml0bWFwX3plcm8oY3R4LT5yZWdzX3dyaXR0ZW4sIFRP
VEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgYml0bWFwX3plcm8oY3R4LT5wcmVkaWNhdGVkX3Jl
Z3MsIFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CisgICAgY3R4LT5pbXBsaWNpdF91c3Jfd3JpdGUg
PSBmYWxzZTsKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQogICAgIGN0eC0+Z3JlZ19sb2dfaWR4
ID0gMDsKICAgICBiaXRtYXBfemVybyhjdHgtPmdyZWdzX3dyaXR0ZW4sIE5VTV9HUkVHUyk7Ci0t
IAoyLjM0LjEKCg==

