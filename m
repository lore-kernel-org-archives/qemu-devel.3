Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09B606A319
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cmf8eOjq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EgzMgW0R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4vA-0006TS-Bc; Thu, 22 Oct 2026 22:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4uq-0006RG-9u
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:22:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4uo-0000tq-MN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 22:21:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1EvdZ1335048
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=; b=Cmf8eOjq+UKmh7ga
 KOYx29SSoLaM18HG38IKFzLhlEAp9Wn7Rw4gTc9LTXP2+Lk2veEuPEacCDoiZiw2
 1YinkSo+RuPOAEH5gnowr7+c9fuTG3hiIKgbpUMQ8XvIsdAJQdakwpUK6QrU5klr
 Yst+bR2R7sKoHOqy1vSMCoJmURngApqMXBNdvGvXCMMw3Jzc3m3SVl8tpryx5Vrc
 qXJ4T+sjm1AsCzfh+tUKRCF/TyAAHjr6OHTdPeCKr8CUbCs9LtTmjgf84qY7Ru4N
 mNjyBYoSV27/Zl9N6cvLbOuIb1Q331gdQLPH1i9dW2CIZRHxiYEmgcdthuGbWCuG
 Ze09JA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8wm0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:21:52 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so1631930c88.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792722112; x=1793326912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=;
 b=EgzMgW0RIvW9O07fVh0VI8hYmCo+B/ThIQ8m+IjAsWiDMF4h/4Z4HrKMwkFphxo083
 sC2vyJn5/w8rOWa5zbNzpr6RHbbZfVUS/ajzOdXjVfjbidFLX696Y/9LnICZ0KDSmPLU
 qupn1NOFzMMJUgKK+SbaYxPJth6QYDqRh2lbSPug54AslXwQkpX593nk0120bwsnDreC
 PNou6MYfZ1eBiPdlugm9XNsS6kQt18JdFfXJ0r806OC+53thaiyF+ZL5PeGBFZiK/74R
 alHi/gcfwAIefZYTscvVyIG2G6zLq4LhiuGL9We7JJXlBTwTzow+96qjLugFPixYP0I/
 pSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792722112; x=1793326912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1tvJx4Gi2s99eA+sQCfV1Wz9PB560tGbzaE1xKyRfpU=;
 b=1oGytDcvfiHMRm/IPqP5D+7phuqvYtADE4ZusCu3Ui6xcJqwsGWPO+C7whQFQm7qr7
 O+dblgAdPTgYWmHEdNWPT9DPa3Go9CRVURK4x2kYalop7HZbQzcII3xs2Gj0fHgl1mdA
 6G4nkguh63aY8OI+BK9q5vbWba5FltdlNR8bW4tndqKo0JlZeYHaE12Rq0x8yf7r3EBJ
 o2alsKFJ0ym2naxMBiNWhxy/oj1lhQxcJ5Hol18fSRe4N9xpNCwmW1aw15sWY4G3fzjQ
 UZ+Hujia4RuI/Bjq1b95TvXEl+8CImJpStRdmoNnuU0hSQfavcfYL8qiJ/4G5ww0hgyP
 JxfQ==
X-Gm-Message-State: AFq9FYLPrM1FRCAGRQmpMPszs3wX6kscmq27qYMmDwU67GF9mPdORhtg
 BO26OubQRGwjYo3H0uTjQB5b54/GhSQvv9i8F7Dg8RtXyq5N4Q3idPiPp6y4sqUgZXqdB1L83/o
 9MXBkXCp+/jfXS05Uhgme8rq2S9/hV+G3WUED7tKjCzLjDA+fP6qwMKuzUwHxzqVo3w==
X-Gm-Gg: AYBFou1B9YjE/25LtOnxKrY0HTxZST4NzVfjuIhCVofZs+XATwkz3IVnF3X6OPT5drx
 7h8wHLrLk8PcgdHz/7+JF1Gd5ugQbC0tTD7uy1Vc6q7jC0IAysQeyFrS0f/oZ4sd4Vp4WxKUjod
 8VZnC1mT5YAF0BvCwC674KPbJ06rMuoZAWyQPDou4fVCBKamRXsKRpIk/fWPZfhK/vfOmh2Tepa
 BiP96S7FBnYpGhFgP6IwJUzqXB7vtKa/Uq+KesNDoIHxSc+xxb4las6nSL5w1no/NdQeF0a2RJS
 JZbq2QEKD2o95pzH7ogT+wcSClbAMakqenAWggOZVvL7oEfDOVzvzv3HzEX/+CZVvEMmzyJSo5A
 MAmC1TZ4DXIvFDiLrQ+lyM7tPj2sfQXYH4cvt5hyV6yPAhEzj
X-Received: by 2002:a05:701b:2508:b0:195:5b0a:7abf with SMTP id
 a92af1059eb24-195c45b0beamr1294148c88.7.1792722111961; 
 Thu, 22 Oct 2026 19:21:51 -0700 (PDT)
X-Received: by 2002:a05:701b:2508:b0:195:5b0a:7abf with SMTP id
 a92af1059eb24-195c45b0beamr1294124c88.7.1792722111379; 
 Thu, 22 Oct 2026 19:21:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eae0e918sm2093713c88.11.2026.10.22.19.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 19:21:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 42/43] target/hexagon: fix semihosting STAT filename handling
Date: Thu, 22 Oct 2026 18:50:39 -0700
Message-Id: <20261023015040.2473105-43-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXzb3KFWzBYNU0
 DswJBQQhmjAEoa8W1PlY+RDlkvUHmTZizjsLzJhgYz1nC16ZvOmIaaMIKZYI6T4do68vdqtcIxe
 GtSzGw+nT8+Az5EYeg8PbeWEl15G2ANCDwwE4bi+0zcHcFDjjVVnhbMTmnFaDx51IFFULjmXdc/
 svrQmFbFoCeTI8/O7GCyFawZPm4aiu6v36s3RrehIUVXbWsTTplZmp91Sx+YTBh1VjmHQpxIK4Z
 McTD1fwt7DfeipcHV5Gu+ov/I5lA7sc534bweRkwQva7lehevlpYeKILQS5N6OzMXutY+sx4LTu
 YIolp9ZlHjjCi9fqcOXFgVbtgcG0+R+hcSv8Nk0uIR3yL6DqaGh5ezmWk3qkB9kTxPdCz/T+21S
 9z8Gw7cOAYcRoYfH2MdfkCW01iwedyvHpvJwbXLb41RQLvgDo2dWGMoaZu8L8A27ulNZRszhXAP
 eZiUlu1blMdQEjEJQSA==
X-Proofpoint-ORIG-GUID: FcQtrrY35pF8btS-_KL3M6rj4gAOWpN1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwOSBTYWx0ZWRfXzOLDYRhsjXmr
 z8r01ThckVaAjWMTMNKy3ot/zEuznEkhAXRwPR1RXdojRGvIcFuUEZTCK2ecHMluE0vbkcvPsLc
 +NFGjtGUyTMgXJPbk6Js4TmiWl59dP8=
X-Proofpoint-GUID: FcQtrrY35pF8btS-_KL3M6rj4gAOWpN1
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adac4c0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vW8nx58EJidmct_-KksA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230009
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDBi
ZTFjMTMwMWU3Li5lYTU1MmExZjFkZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2OCw3ICs1NjgsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzcsMTUgKzU3NywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

