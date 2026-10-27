Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F31606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XjRSEU7W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M0Y/T0GR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiKX-0000XC-6f; Tue, 27 Oct 2026 10:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJl-0007tB-1k
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJj-00066K-5M
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:38:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo3pW2881601
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=; b=XjRSEU7WeeMqtOBh
 nr+3/GSS0M/jktr/p4iZq0k/L0CCf9Y0c5pstHJwNUs6lJESoRE0A5vjplSRvKYr
 2fF7eOzFBVJUd/JGlLUZKYUllEuNvEuQ5RLuHH5aFvktx8NtcX/7kbPurieDRYkP
 SkYBa1fBHlgdHTOeXxgit7FXSlEBFQ3KaLa3cgqjVeyHF+N+UK4aZIN7k2EdI6BM
 B7U6KgF4zxgDFDcywp/QTC+gopLILNqhO7DDVaoZsIgm3hCy1GGv0tiB7W7pk1NN
 76ukl0gSm0Sq3AP7yQAfT8ichtAE/crGsCwliaYoKPWaRjG/1UbvdGIZDgPsNKih
 ONNvUg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtasvj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:38:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc7e0321ec1so17080a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111891; x=1793716691; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=M0Y/T0GRa/WQ9jvabyadxvssE108fv6dvvKmAKA/d40cWWZoijKxzrRdKU1VOoi5m+
 Oxw6jUZdqF55dtJVzmjTQ+e2PaQt6I19rwANs0hDUkXAR67ZhUQ0kYSTARg1hQHIhB+C
 Mpx6sSbfE/Qj4IPOde+436OWu3YHyw/CDRLgPDJsw6SFUUq2IePtKtRKKnbx3LbRjdfU
 RbUJDdW18V7+O1nmDF2RVpkfAdHXTjR/GMP0KLCawM811t4DnNo+30IRMUIWwOg0XzCm
 SUMEpXY0tEzJooJscjA+i5ne+Dc7E80RxKfPLYQp2JmbV8CKI8+owhAZ/qDJfwf0YhHp
 smlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111891; x=1793716691;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=82GTbX6co+CHV5P+y9vLi0NwE9T6aLWO6fg1F5HK7Zs=;
 b=e5dnaC2K3/zz6tQdjAqI0bCBkq1T4ObQtMPhQaoBOo0i0imLABqFUHr0xxzORPWUmh
 P8IXgquK2i0Mx5bunYTe1VbAFEu3wFRi5O6ASNd01HrkViRpgzjhLWpy0SYDgpz3UCDY
 HZrR/SMziud7SeOq8HCZ4Lbka0L+zmnAhM5xfXvg4NXvkNfjeD6Sq8aJnIYUnPggSDwN
 lV0+9bE931JyczEqCA35FUyNfAwR71jWjLWnYZG3Gi07BD7Lj+QzqYehxDgl0tU+f44E
 3QNzER1sUpCoAimNFtDtx5WEpt7Ev/O3SAl9VKRZN5aHOo9jGdcf1SsOSQFw6m5BbqWW
 fU0g==
X-Gm-Message-State: AFq9FYJjRvJDwH7IPpdTbH9ng+z4ZTJZ1zPW99uDqak/VCnXh4MswXty
 g1FdNUVEg9f0F23YzVehx3a3xTG+stxarL+TvNl2xbNjxTnQMizsazQvYpt2lPSeq6Zgvg0X2/3
 NArlcdnTdRGu5Zxf7Qgn6CxMd68USgvJl90k3bB5VjbNXZ9IFUVLXwV4PwDOrblnVVA==
X-Gm-Gg: AYBFou2EQ7y2Lcj1YSESz46RNAiWmhUZiLlXX4cOzv3w+UG9yCoUSQG2eJSbMBt/2/l
 tiKqKuC+5LI5MLeDOOq5SuBkc2DdpjrMV8okZe8KylxJ3/Wqqy3OZeBG9BgrgMNXT9YjseJYHXN
 CHUFBaboJn9xWsouMGiL0OSSRYqeQtFqR4kZN0ASZVz38DCkcLUDrz63HnSKZkt5LiBvbgBQ9J2
 acl+w4fkte8cBm3iu0qPrYv4uJLWlvEe3GqIOl4geXy1/QmRQ9Qz5PhX3K6FQ1b0jynzgAgEhQi
 vSQwJg1ukUjwIfataEqyN417TWj13jBrarcM2isRUNr6Eao+zwO+Ln7nBHCfDBT/ZtioqIyAyam
 OEPguYmYrRJQqVxi4+FvIL5ilkUskbc+Mi7lTXrDEpkP9D80=
X-Received: by 2002:a17:90b:2e10:b0:3ab:e588:c29b with SMTP id
 98e67ed59e1d1-3adea1ad712mr9087404a91.5.1793111891286; 
 Tue, 27 Oct 2026 07:38:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2e10:b0:3ab:e588:c29b with SMTP id
 98e67ed59e1d1-3adea1ad712mr9087385a91.5.1793111890769; 
 Tue, 27 Oct 2026 07:38:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:38:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 19/42] hw/hexagon: let a machine place its DDR
Date: Tue, 27 Oct 2026 07:36:58 -0700
Message-Id: <20261027143721.4125584-20-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX+W6QdUjw3Oh7
 MZDqv21nVwHjulSDcwwR5PKZOIAO2JqBqAyvPPMVElB2pG5Z3nbalkrDqVX1hU3nksISO0N845/
 Vuc9avI0bPZ+4qcT8Z+zGncwz6Ewnpo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX1HH0pfW82OKU
 PwcqTZJoO27M/fYYn5eHMfyy6LZSZKAINi+K3Gij4mBRgTWp16Uga+y26t6SqdkvXw2ekfJhMbr
 SuDbvFPZIapEl3nMHsn3vWDvusFxhbUmY+qNH1Nt4vbGxX/ewkedJoYpggu2jvFEGHj5Gr7XUcY
 fsYDYUhIhytfcp2EldciUi1RTML2o9rkRuEG009xkSGlDAtZyVL5GBkV4W7+VaRp3xJs7Tyj/DA
 d3kmIgpEzUM0N2dOnJfrzaA3zaIKprLfbA/Rl3N/iORUzJPB5HdSLhJMrLImBPH4ps/uLChpA7G
 FNTI0hWGdug2aBS5ulNC2YfPsvH1TQHgJoTMIUKZBCPhiuXYwfzr89iLkpabkYf0QGYgyy2lZm2
 V6HpBa0yuyZ69EwNih74eWfizCK8QmAs+pUMFNWJ7CGRwxTwSsQMSbG6elOwjD4OzMw8p+Wxasv
 Cv4AANl7DgDWNgbU0XA==
X-Proofpoint-ORIG-GUID: VxWGFq7uz4AXQoCWTLITIYvm-hd5e5TB
X-Proofpoint-GUID: VxWGFq7uz4AXQoCWTLITIYvm-hd5e5TB
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0b754 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aYFWVRUMB-liYKm9W0cA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

aGV4X3N1YnN5c19jcmVhdGUoKSBhbHdheXMgbWFwcyB0aGUgbWFpbiBERFIgYXQgYWRkcmVzcyAw
LiAgVGhpcyBpcyBhcHByb3ByaWF0ZQpmb3IgaGV4YWdvbi1zaW0tc3R5bGUgbWFjaGluZXMsIGJ1
dCByZWFsIFNvQ3MgbWFwIGl0IGVsc2V3aGVyZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBpbmNsdWRlL2h3L2hl
eGFnb24vaGV4YWdvbi5oIHwgMiArKwogaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgICAgICB8IDQg
KystLQogMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24uaCBiL2luY2x1ZGUvaHcvaGV4
YWdvbi9oZXhhZ29uLmgKaW5kZXggNzk2MTdhMDY4ZGEuLjAxZWQwM2NjODMzIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9o
ZXhhZ29uLmgKQEAgLTE0OCw2ICsxNDgsOCBAQCB1bmlvbiBoZXhhZ29uX2NvbmZpZ190YWJsZSB7
CiB9OwogCiBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyB7CisgICAgLyogQmFzZSBhZGRy
ZXNzIG9mIHRoZSBtYWluIEREUiByZWdpb24gKi8KKyAgICBod2FkZHIgZGRyX2Jhc2U7CiAgICAg
LyogQmFzZSBhZGRyZXNzIG9mIGNvbmZpZyB0YWJsZSAqLwogICAgIHVpbnQzMl90IGNmZ2Jhc2U7
CiAgICAgLyogU2l6ZSBvZiBMMiBUQ00gKi8KZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4LXN1
YnN5cy5jIGIvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMKaW5kZXggOTgxOGNmNTg4NzguLjM4MmY0
NWJkMDlmIDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleC1zdWJzeXMuYworKysgYi9ody9oZXhh
Z29uL2hleC1zdWJzeXMuYwpAQCAtMTM2LDEwICsxMzYsMTAgQEAgdm9pZCBoZXhfc3Vic3lzX2Ny
ZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsCiAgICAgTWFjaGluZVN0YXRlICpt
YWNoaW5lID0gTUFDSElORShobXMpOwogICAgIE1lbW9yeVJlZ2lvbiAqc3lzbWVtID0gZ2V0X3N5
c3RlbV9tZW1vcnkoKTsKIAotICAgIC8qIE1haW4gRERSIGF0IHRoZSByZXNldCB2ZWN0b3IuICov
CisgICAgLyogTWFpbiBERFIuICovCiAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X3JhbSgmaG1zLT5y
YW0sIE5VTEwsICJkZHIucmFtIiwgbWFjaGluZS0+cmFtX3NpemUsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmZXJyb3JfZmF0YWwpOwotICAgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJlZ2lv
bihzeXNtZW0sIDB4MCwgJmhtcy0+cmFtKTsKKyAgICBtZW1vcnlfcmVnaW9uX2FkZF9zdWJyZWdp
b24oc3lzbWVtLCBtX2NmZy0+ZGRyX2Jhc2UsICZobXMtPnJhbSk7CiAKICAgICAvKiBDb25maWct
dGFibGUgUk9NIGFuZCB0aGUgYmxvYiB0aGF0IGJhY2tzIGl0LiAqLwogICAgIG1lbW9yeV9yZWdp
b25faW5pdF9yb20oJmhtcy0+Y2ZndGFibGVfcm9tLCBOVUxMLCAiY29uZmlnX3RhYmxlLnJvbSIs
Ci0tIAoyLjM0LjEKCg==

