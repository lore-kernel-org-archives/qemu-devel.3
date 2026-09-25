Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A23C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9P-0004xj-FV; Thu, 24 Sep 2026 21:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9L-0004wK-My
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9J-0005ss-Ak
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1klt9313539
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l6JeBLh6ZKEYU/jz27Wq9yqtD8AwYSMdy7kdssj+xxQ=; b=TTdoYO72j839vhJD
 rc9s+nkwO7CGjvUVT8W6Pf0ueABskNB07vLJjwlJy/A8FrCUKCq+QDvvdZEUpXpN
 7dwIv7b51BZU78jz8Ayxp9ggWUlNFLLGq1XaqkkqdzpMgmvhj9WjPKJbXUuI5qfV
 3QqP6umhLpIP4RAbljO4ozAtbBXL518ZM3aHoIniilv+VsWOE1//G8s2mRb9bcE0
 GeTKTt35DAsMyoVhM19qg6XgMRljvYptiCbL+KtR0213zORtRFrodTdrbd3TgDpJ
 nOeFJApXBbz8zwx5GSkuxgbG1Ediwiul5h9g4QKZVCcdtHua06Ly3iQYfupQW0AK
 mWMuUQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1s93d7q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-331b2ec616fso1392708eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301291; x=1790906091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l6JeBLh6ZKEYU/jz27Wq9yqtD8AwYSMdy7kdssj+xxQ=;
 b=RT9nKuWrzTPQDFjIo8pw7xsL2nec0B4ta/hovDs01Q6UXM+97fviy6Dot8PXIrII4q
 D+bnBJavPXfuPv0EGrgIVpGBST0uLEN2rMManViPQZXnBoEJRDhOo4rW3kEdGnCUMKO0
 XkOtE5uIgQBAFJBq5ZNzu+FQQKbszwB1D+Flal0MOlSGeIKn7Y7vdeJmf3ODmRFqOCrC
 5bse0OXfJaSoC6H0/d4IyTVNvuUeimq7u5r5RDB0ZBPZ8zNPfKXKBUXgL2ObAMBF6QCn
 5VgqPSzHX/JaM/x6AKwHLlbUHbl+j2AxaALT1K+ipPu9IPmslap2uSxWxg1oIBbgKhm9
 K+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301291; x=1790906091;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6JeBLh6ZKEYU/jz27Wq9yqtD8AwYSMdy7kdssj+xxQ=;
 b=Ra9D++rkkwcNOEGEEgEgx6Vcqz1SJdOoCJbouGB354VUNvZnIyNTbwV/KU8MIMBa42
 LOv7P4MRUiHgu08cBQe/VfsKjsv44/74KkAX/pavOJN2Bx+cWycLlTaWofYrqnefWERX
 cgfO9+ayGdW4SzVewfb2IoQDLhi46DuSyZfxd7UVPu8SyAgXgn2Ro2f//+YK6xRHbzcv
 QNpn4NCa3xSPKD9FDAp/ZteJ+hqDUAiQvpTqaDiTVMZgfEi1kYPvnzxa5Qnau7KkwJRJ
 5B7SQ1hxBMdcfIrDfjb35yo9/+vk8eThySDsLqtM0yrnBIJqJ/4LjwaamV4/nQkdc/RJ
 JKHg==
X-Gm-Message-State: AFuF++mRiHrbK6Cg8T9VKWMB0Q8K/VY7nas0pM/8E2NUluZYJvbZduAy
 iCKoTUIViBGOEAckn5QCRzakd/Ftesa+1N/oFXrj+8YKuN+EMGNXNRkjn63pyhhWpG0qjNnpji6
 UHrBDEbT1comqGZNbsuMY0dS5ZwK7znOpCamJaRuw6W5givVogDj0nzvkBbjtnHcxKA==
X-Gm-Gg: AYBFou1Bim4qMvb0UD4mFShmcUl7DI9JQbdPo22MzqiUlaBsq9829cHylJAKhdmrWR8
 K1/oGMAMriFg2iDv6gGO4CoOJuenTIbUowuZb2KlbjC1wJa340/8yFK1LfPZRA06zuX6uvUiSRx
 d4/QMfJYF4/CF/0PUEfsU9NgMiaiIuhi9WoQy7LJmkY6j54eufQhh0kTg+Yy+TlAy+5fmhM2zD5
 gEa0ZG/dGgJPc3jglBXj7nfrW0vQuwLbXgLHiqHQrpEHGYwUMrx72KLdC6Hz3wwsVbLz40qfLjx
 ehlCnjGRujlLpB6oKfuvQ4M4cVhCJ0Y2Xs7vT3kb6K7eWfmAWOMs/uBFo/uw3GDd5ZU5qcnsxW3
 K+3zs5G96dW/lILFMYe+mn1gTkpSKdIaBb/gmYADbzjdmXUU=
X-Received: by 2002:a05:693c:8812:10b0:33c:16c5:6f3d with SMTP id
 5a478bee46e88-340040a6d47mr3324552eec.37.1790301290845; 
 Thu, 24 Sep 2026 18:54:50 -0700 (PDT)
X-Received: by 2002:a05:693c:8812:10b0:33c:16c5:6f3d with SMTP id
 5a478bee46e88-340040a6d47mr3324535eec.37.1790301290228; 
 Thu, 24 Sep 2026 18:54:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 10/40] Hexagon (target/hexagon) Remove old way of detecting
 register multiwrites
Date: Thu, 24 Sep 2026 18:53:59 -0700
Message-Id: <20260925015429.2579174-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX2O7ZdwEee2tz
 gpgHQ4PGPnyqkPGlNvKyT8/cen0F5r95MBaICJsgHoOwtbGLlJyteVt+BJTbjW6YUVFOlwYpMTK
 JD0wW1Tqhg2TvRWMuRwmQMZsS9+7k3Kdiex8rVwSGRXHGwEeBN6QThW2ANiF0pxLYPXOcDj/Mmp
 Vz5IYZ/6QyrF+NsKfra+af79FDlOugDPBQUU6tFgud1jNEhYYqFHzQUd2bnyd8gRBlxZWkNV3M6
 027wF+HahfeP3dQ421eLX1nGoVHrw94FJwnnbc8pVBN2tLe4yaqeDh0bb/l9F5hx0VTK5CU9jUj
 xPtLr4BWkWypwDfHP//HBLeilFikMFNgGLHxq9YL2zuYdZB09MOUziF4lDbHRTH+gByehKXDiai
 FIdSMjAa7pUezFZpb8/tCizO8AorF8uia6lnppv1YPNYwOnLk3OApws3kbRwnedOxwPoNWylOd4
 XOroO5zBHiToHS4eG0w==
X-Authority-Analysis: v=2.4 cv=VPxIDNPX c=1 sm=1 tr=0 ts=6ab5d46b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZOAZYkgrj4wqSO_QGjIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX2+hLcdcgCVwY
 8wm72wmojW6S2572GnWUhR6olD0WbZo9xuxlhik11Y4rEsoIPMHgWglv9qR8qPG+QZ6zXOXlonE
 lN0vszaLXxEPr15YyrDEJanxBPRzIRk=
X-Proofpoint-ORIG-GUID: NoVqWnwOIxlMuJFpFK6Aap-hWMEd4KFS
X-Proofpoint-GUID: NoVqWnwOIxlMuJFpFK6Aap-hWMEd4KFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCldlIG5vdyBk
ZXRlY3QgcmVnaXN0ZXIgbXVsdGl3cml0ZXMgaW4gcGFja2V0IGFuYWx5c2lzIGluc3RlYWQgb2YK
cGFja2V0IGRlY29kaW5nCgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3Nz
LnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1w
c29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICB8ICA0
IC0tLQogdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgICAgICAgICAgIHwgNTQgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgICAgICAgIHwg
IDYgLS0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5IHwgMTAgLS0tLS0tCiA0
IGZpbGVzIGNoYW5nZWQsIDc0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhh
Z29uL2luc24uaCBiL3RhcmdldC9oZXhhZ29uL2luc24uaAppbmRleCA4MzViMWM5NTRlZC4uNWQ1
OTQzMGRhOWUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2luc24uaAorKysgYi90YXJnZXQv
aGV4YWdvbi9pbnNuLmgKQEAgLTQxLDggKzQxLDYgQEAgc3RydWN0IEluc3RydWN0aW9uIHsKICAg
ICB1aW50MzJfdCBuZXdfdmFsdWVfcHJvZHVjZXJfc2xvdDo0OwogICAgIGludDMyX3QgbmV3X3Jl
YWRfaWR4OwogICAgIGludDMyX3QgZGVzdF9pZHg7Ci0gICAgYm9vbCBkZXN0X2lzX3BhaXI7Ci0g
ICAgYm9vbCBkZXN0X2lzX2dwcjsKICAgICBib29sIGhhc19wcmVkX2Rlc3Q7CiAKICAgICBib29s
IHBhcnQxOyAgICAgICAgICAgICAgLyoKQEAgLTc0LDggKzcyLDYgQEAgc3RydWN0IFBhY2tldCB7
CiAgICAgYm9vbCBwa3RfaGFzX2h2eDsKICAgICBJbnNuICp2aGlzdF9pbnNuOwogCi0gICAgYm9v
bCBwa3RfaGFzX3dyaXRlX2NvbmZsaWN0OwotCiAgICAgSW5zbiBpbnNuW0lOU1RSVUNUSU9OU19N
QVhdOwogfTsKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQv
aGV4YWdvbi9kZWNvZGUuYwppbmRleCBiMTJlOTFmZTZhNi4uODllOTYxMzMxZmYgMTAwNjQ0Ci0t
LSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5j
CkBAIC02OTEsNTUgKzY5MSw2IEBAIGJvb2wgb3Bjb2RlX3N1cHBvcnRlZCh1aW50MTZfdCBvcGNv
ZGUsIGNvbnN0IEhleGFnb25DUFVEZWYgKmhleF9kZWYpCiAgICAgcmV0dXJuIHRydWU7CiB9CiAK
LS8qCi0gKiBDaGVjayBmb3IgR1BSIHdyaXRlIGNvbmZsaWN0cyBpbiB0aGUgcGFja2V0LgotICog
QSBjb25mbGljdCBleGlzdHMgd2hlbiBhIHJlZ2lzdGVyIGlzIHdyaXR0ZW4gYnkgbW9yZSB0aGFu
IG9uZSBpbnN0cnVjdGlvbgotICogYW5kIGF0IGxlYXN0IG9uZSBvZiB0aG9zZSB3cml0ZXMgaXMg
dW5jb25kaXRpb25hbC4KLSAqCi0gKiBUT0RPOiBoYW5kbGUgdGhlIG1vcmUgZ2VuZXJhbCBjYXNl
IG9mIGFueQotICogcGFja2V0IHcvbXVsdGlwbGUtcmVnaXN0ZXItd3JpdGUgb3BlcmFuZHMuCi0g
Ki8KLXN0YXRpYyBib29sIHBrdF9oYXNfd3JpdGVfY29uZmxpY3QoUGFja2V0ICpwa3QpCi17Ci0g
ICAgREVDTEFSRV9CSVRNQVAoYWxsX2Rlc3RfZ3BycywgMzIpID0geyAwIH07Ci0gICAgREVDTEFS
RV9CSVRNQVAod3JlZ19tdWx0X2dwcnMsIDMyKSA9IHsgMCB9OwotICAgIERFQ0xBUkVfQklUTUFQ
KHVuY29uZF93cmVnX2dwcnMsIDMyKSA9IHsgMCB9OwotICAgIERFQ0xBUkVfQklUTUFQKGNvbmZs
aWN0LCAzMik7Ci0KLSAgICBmb3IgKGludCBpID0gMDsgaSA8IHBrdC0+bnVtX2luc25zOyBpKysp
IHsKLSAgICAgICAgSW5zbiAqaW5zbiA9ICZwa3QtPmluc25baV07Ci0gICAgICAgIGludCBkZXN0
ID0gaW5zbi0+ZGVzdF9pZHg7Ci0KLSAgICAgICAgaWYgKGRlc3QgPCAwIHx8ICFpbnNuLT5kZXN0
X2lzX2dwcikgewotICAgICAgICAgICAgY29udGludWU7Ci0gICAgICAgIH0KLQotICAgICAgICBp
bnQgcm51bSA9IGluc24tPnJlZ25vW2Rlc3RdOwotICAgICAgICBib29sIGlzX3VuY29uZCA9ICFH
RVRfQVRUUklCKGluc24tPm9wY29kZSwgQV9DT05ERVhFQyk7Ci0KLSAgICAgICAgaWYgKHRlc3Rf
Yml0KHJudW0sIGFsbF9kZXN0X2dwcnMpKSB7Ci0gICAgICAgICAgICBzZXRfYml0KHJudW0sIHdy
ZWdfbXVsdF9ncHJzKTsKLSAgICAgICAgfQotICAgICAgICBzZXRfYml0KHJudW0sIGFsbF9kZXN0
X2dwcnMpOwotICAgICAgICBpZiAoaXNfdW5jb25kKSB7Ci0gICAgICAgICAgICBzZXRfYml0KHJu
dW0sIHVuY29uZF93cmVnX2dwcnMpOwotICAgICAgICB9Ci0KLSAgICAgICAgaWYgKGluc24tPmRl
c3RfaXNfcGFpcikgewotICAgICAgICAgICAgaWYgKHRlc3RfYml0KHJudW0gKyAxLCBhbGxfZGVz
dF9ncHJzKSkgewotICAgICAgICAgICAgICAgIHNldF9iaXQocm51bSArIDEsIHdyZWdfbXVsdF9n
cHJzKTsKLSAgICAgICAgICAgIH0KLSAgICAgICAgICAgIHNldF9iaXQocm51bSArIDEsIGFsbF9k
ZXN0X2dwcnMpOwotICAgICAgICAgICAgaWYgKGlzX3VuY29uZCkgewotICAgICAgICAgICAgICAg
IHNldF9iaXQocm51bSArIDEsIHVuY29uZF93cmVnX2dwcnMpOwotICAgICAgICAgICAgfQotICAg
ICAgICB9Ci0gICAgfQotCi0gICAgYml0bWFwX2FuZChjb25mbGljdCwgd3JlZ19tdWx0X2dwcnMs
IHVuY29uZF93cmVnX2dwcnMsIDMyKTsKLSAgICByZXR1cm4gIWJpdG1hcF9lbXB0eShjb25mbGlj
dCwgMzIpOwotfQotCiAvKgogICogZGVjb2RlX3BhY2tldAogICogRGVjb2RlcyBwYWNrZXQgd2l0
aCBnaXZlbiB3b3JkcwpAQCAtNzU5LDEwICs3MTAsNiBAQCBpbnQgZGVjb2RlX3BhY2tldChEaXNh
c0NvbnRleHQgKmN0eCwgaW50IG1heF93b3JkcywgY29uc3QgdWludDMyX3QgKndvcmRzLAogCiAg
ICAgLyogSW5pdGlhbGl6ZSAqLwogICAgIG1lbXNldChwa3QsIDAsIHNpemVvZigqcGt0KSk7Ci0g
ICAgZm9yIChpID0gMDsgaSA8IElOU1RSVUNUSU9OU19NQVg7IGkrKykgewotICAgICAgICBwa3Qt
Pmluc25baV0uZGVzdF9pZHggPSAtMTsKLSAgICAgICAgcGt0LT5pbnNuW2ldLm5ld19yZWFkX2lk
eCA9IC0xOwotICAgIH0KICAgICAvKiBUcnkgdG8gYnVpbGQgcGFja2V0ICovCiAgICAgd2hpbGUg
KCFlbmRfb2ZfcGFja2V0ICYmICh3b3Jkc19yZWFkIDwgbWF4X3dvcmRzKSkgewogICAgICAgICBJ
bnNuICppbnNuID0gJnBrdC0+aW5zbltudW1faW5zbnNdOwpAQCAtODM3LDcgKzc4NCw2IEBAIGlu
dCBkZWNvZGVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbWF4X3dvcmRzLCBjb25zdCB1
aW50MzJfdCAqd29yZHMsCiAgICAgICAgICAgICAvKiBJbnZhbGlkIHBhY2tldCAqLwogICAgICAg
ICAgICAgcmV0dXJuIDA7CiAgICAgICAgIH0KLSAgICAgICAgcGt0LT5wa3RfaGFzX3dyaXRlX2Nv
bmZsaWN0ID0gcGt0X2hhc193cml0ZV9jb25mbGljdChwa3QpOwogICAgIH0KICAgICBkZWNvZGVf
ZmlsbF9uZXd2YWx1ZV9yZWdubyhwa3QpOwogCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90
cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IDgxZjg4OTVlNDdi
Li44NTYxY2VjNGU0MSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysr
IGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTEyNTMsMTIgKzEyNTMsNiBAQCBzdGF0
aWMgdm9pZCBkZWNvZGVfYW5kX3RyYW5zbGF0ZV9wYWNrZXQoQ1BVSGV4YWdvblN0YXRlICplbnYs
IERpc2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjbGVhcl9wa3RfY3R4KGN0eCk7CiAgICAgICAg
IGFuYWx5emVfcGFja2V0KGN0eCk7CiAKLSAgICAgICAgLyoKLSAgICAgICAgICogQ2hlY2sgdGhh
dCB0aGUgbmV3IG1ldGhvZCBpcyBhIHN1cGVyc2V0IG9mIHRoZSBvbGQgbWV0aG9uZAotICAgICAg
ICAgKiBSZW1vdmUgaW4gYSBsYXRlciBwYXRjaAotICAgICAgICAgKi8KLSAgICAgICAgZ19hc3Nl
cnQoIWN0eC0+cGt0LnBrdF9oYXNfd3JpdGVfY29uZmxpY3QgfHwKLSAgICAgICAgICAgICAgICAg
cGt0X2hhc193cml0ZV9jb25mbGljdChjdHgpKTsKICAgICAgICAgaWYgKHBrdF9oYXNfd3JpdGVf
Y29uZmxpY3QoY3R4KSkgewogICAgICAgICAgICAgZ2VuX2V4Y2VwdGlvbl9kZWNvZGVfZmFpbChj
dHgsIHdvcmRzX3JlYWQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhF
WF9DQVVTRV9SRUdfV1JJVEVfQ09ORkxJQ1QpOwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Z2VuX3RyYW5zX2Z1bmNzLnB5IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5Cmlu
ZGV4IDE5YzFmOWZkZWE1Li40NWRhMWI3YjVkZiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Z2VuX3RyYW5zX2Z1bmNzLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5w
eQpAQCAtOTEsOCArOTEsNiBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYpOgogICAgICAgICBuZXdf
cmVhZF9pZHggPSAtMQogICAgICAgICBkZXN0X2lkeCA9IC0xCiAgICAgICAgIGRlc3RfaWR4X3Jl
Z19pZCA9IE5vbmUKLSAgICAgICAgZGVzdF9pc19wYWlyID0gImZhbHNlIgotICAgICAgICBkZXN0
X2lzX2dwciA9ICJmYWxzZSIKICAgICAgICAgaGFzX3ByZWRfZGVzdCA9ICJmYWxzZSIKICAgICAg
ICAgZm9yIHJlZ25vLCAocmVnX3R5cGUsIHJlZ19pZCwgKl8pIGluIGVudW1lcmF0ZShyZWdzKToK
ICAgICAgICAgICAgIHJlZyA9IGhleF9jb21tb24uZ2V0X3JlZ2lzdGVyKHRhZywgcmVnX3R5cGUs
IHJlZ19pZCkKQEAgLTEwNiwxMiArMTA0LDYgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToKICAg
ICAgICAgICAgICAgICBpZiBkZXN0X2lkeF9yZWdfaWQgaXMgTm9uZSBvciByZWdfaWQgPCBkZXN0
X2lkeF9yZWdfaWQ6CiAgICAgICAgICAgICAgICAgICAgIGRlc3RfaWR4ID0gcmVnbm8KICAgICAg
ICAgICAgICAgICAgICAgZGVzdF9pZHhfcmVnX2lkID0gcmVnX2lkCi0gICAgICAgICAgICAgICAg
ICAgIGRlc3RfaXNfcGFpciA9ICgidHJ1ZSIKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmIGlzaW5zdGFuY2UocmVnLCBoZXhfY29tbW9uLlBhaXIpCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbHNlICJmYWxzZSIpCi0gICAgICAgICAgICAgICAgICAg
IGRlc3RfaXNfZ3ByID0gKCJ0cnVlIgotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiByZWdfdHlwZSA9PSAiUiIKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZWxzZSAiZmFsc2UiKQogICAgICAgICAgICAgaWYgcmVnX3R5cGUgPT0gIlAiIGFuZCByZWcuaXNf
d3JpdHRlbigpIGFuZCBub3QgcmVnLmlzX3JlYWQoKToKICAgICAgICAgICAgICAgICBoYXNfcHJl
ZF9kZXN0ID0gInRydWUiCiAKQEAgLTEzNyw4ICsxMjksNiBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNz
KGYpOgogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAgICAgICBpbnNuLT5u
ZXdfcmVhZF9pZHggPSB7bmV3X3JlYWRfaWR4fTsKICAgICAgICAgICAgIGluc24tPmRlc3RfaWR4
ID0ge2Rlc3RfaWR4fTsKLSAgICAgICAgICAgIGluc24tPmRlc3RfaXNfcGFpciA9IHtkZXN0X2lz
X3BhaXJ9OwotICAgICAgICAgICAgaW5zbi0+ZGVzdF9pc19ncHIgPSB7ZGVzdF9pc19ncHJ9Owog
ICAgICAgICAgICAgaW5zbi0+aGFzX3ByZWRfZGVzdCA9IHtoYXNfcHJlZF9kZXN0fTsKICAgICAg
ICAgIiIiKSkKICAgICAgICAgZi53cml0ZSh0ZXh0d3JhcC5kZWRlbnQoZiIiIlwKLS0gCjIuMzQu
MQoK

