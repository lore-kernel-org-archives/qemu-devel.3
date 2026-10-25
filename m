Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8C606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ncAePM24;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j14ugbbv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKosU-0002Pm-GI; Sat, 24 Oct 2026 23:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqe-0007nH-G9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xKoqa-0001US-IT
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 23:24:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69P16ZfP2051390
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=; b=ncAePM24h5jfNvf+
 LyQFt05Ha6DJuvdb3FIVRpLL+havVLPQi36JT3goBwdNDe2oHSPxF/Zz7a8GLjX0
 CsWnsOwZYukWhUi1L26C2O5ttMuzs+us2jVPCfGir8BJ+shzynyarzSt1sTG2oxk
 SfU/FmjiQtOB9cWgVRiJBDJ/TtFyxuMqB3mC7YcK09yAQGT1GL1iuLpstkKSdlfN
 iHTfwWS0PHl8EDqq09kcrScaKT2/kdkcY4w31K18RfFiLZ4gCjtSptfa5eopS1Cu
 bM02PqQEsY81KVTVUC4H7hQ3eLC1dLZEj3oD1NT5iA2tbbcIqzROTMMQxv9c+szE
 7wO2sg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgn27t9yh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 03:24:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so8638439c88.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792898665; x=1793503465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=j14ugbbvk3aUWAIjE3O6b+TRvtEjy/L5qRzL57XBap2DnxLnBWyx/xOGQWJWp+CwWi
 DlzblcV0R/7Q8TFwCjzYj9bFNT5VvdGoxmPMMRWX3+L4VfhncBf7j9v9mxfaLovQOdND
 7plOOMDNQQB3VP+jkpCSqorgx1jRMumoBiZhJqifBRZP4uQbZ124nxKWtdpFkawQv+yT
 0AXA2Dj7XLg6WGhqmG5uaBqRxxXw4XtCm3vxcgw8losh5NuVzMuMe9xLhWOqGgyB0UHM
 uMW4l9EXQcx92re87aMrgSjSwrrq+5peBSDhuf26DWOBXcPEprNqpSwYsZ/VgacpwvbC
 HFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792898665; x=1793503465;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r3WOvdRk6q9uOwIyLgCWCr89tN5UwlkzfMPmHZ8doEE=;
 b=e4JJiW7ZWnrgBnet4e/l7Yq+O4E+nZ1VbMYwetBvz3AnYQu41CdVhuwayiTJJuTV9w
 23/uwsz4GQHsC0WO28cEUgO5ivIgAJYRMPG1ph5CPnVJKZu0gZMdtVD5AoJ1alLHfmAm
 iN10JW9HiKk6CwS3HhfhGFrDukhmBDaWKMU7feeUKlUiauJOR+T3Gxf+Kx4emc/3ooQm
 UL2MI8qpown8/KTwrs/2TFYbKLdixW//zW5zDp2zk3e2Uw8TZHRGQri9YR8WudgK2BF2
 WRzxQOBFbkaa282G6cY2XrPrHPuQ01hryIMGT9Xf8yHeb+nPlHU3GhlMZucfJtfV2N21
 xMbw==
X-Gm-Message-State: AFq9FYLHGKL0BJYqOO6zFGwrsofh0IIFUF8MRx/yi/YrLbz13+hCOalk
 bdFSyX8Zp4hrJom0nvbqr58TevJMV16I6fWwAAmdZwO0Z4XCPiuVFqjA+h/dpsZB55P9Vdp4PW1
 thHCQ8TF7GFFaVh7dxs9eO0489G6bheQEt5ws9AcKzQEYCajeqK2OMyoqs2VeHg/UYQ==
X-Gm-Gg: AYBFou0cFOZZEZgSk+jaJHtpY9qIcsYzvHXd19J00saixsvEZdMWAOjU/d5KDl4WKFC
 OEJ/Urg4YlRjhqmmfhMM4P0OzXfpSGLm4M1LCLXnGcpNqkywlKXzAGXbee30DpgQH/+0EFTLdfa
 3Y7IzymuDP8lpCwu0iKsocZFJljetPLUBgymCYGU4/+fKP7xIhjp2E3a2EZBxAcDdwcwMAIGKjf
 R1r96SlugvIQ4lgI/7v6jYfNCGTdamdKYwj43IFXBNISCXmFAz46rj37KnRT0maaohy2RSDOWDe
 lzc93saMhaYDuza6ZWfibIpAEkmaI3sa93nUzX8CKyr6+A+AWYJ4uIYN9NhBjVF4KBWb6HzRerL
 9Kw/7dWY5IurIxWEHCEnKyCGZVFbj/X32O3Qa91rZ54SC+cY=
X-Received: by 2002:a05:7022:23a9:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1993fe81364mr7187636c88.39.1792898664599; 
 Sat, 24 Oct 2026 20:24:24 -0700 (PDT)
X-Received: by 2002:a05:7022:23a9:b0:158:1ed2:cb58 with SMTP id
 a92af1059eb24-1993fe81364mr7187606c88.39.1792898664047; 
 Sat, 24 Oct 2026 20:24:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a249c331sm26812581c88.17.2026.10.24.20.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 20:24:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 17/40] target/hexagon: fix semihosting STAT filename handling
Date: Sat, 24 Oct 2026 20:23:23 -0700
Message-Id: <20261025032346.2917451-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
References: <20261025032346.2917451-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=G7GJgNk5 c=1 sm=1 tr=0 ts=6add7669 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=vW8nx58EJidmct_-KksA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Lq9Kl9GpWcQvI5ZzV8x5tsblgRHOMXPe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX9rz3D0aMm5ov
 nyWok9M8IkRe8DTIOOADWLa3Co1ZIUToSYOUnp/HezejI+qcVxQewC8m//ANMYZ7Af1x/b7gS7f
 Qm8osNfdFE2dLyW5INoC6RTUY7yqTVQ=
X-Proofpoint-GUID: Lq9Kl9GpWcQvI5ZzV8x5tsblgRHOMXPe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI1MDAxMiBTYWx0ZWRfX6H5dAkuugb+O
 IqLtoezid3f9rauwLdNLtE+oo8kVKDu+0Id/TGWsiJkrzSy0Mmhdv4p7CoGPCQfuhsZas7YuYR/
 BKBlY/ovOwONYTUxYFdmJU6mrLGbPXxcGFFXPNohNY8p8ABvPMWzlJKXAY+T2N1eJDEqcCwj2mY
 1z6AlYgtkoA6L+zwQU/zW69UqZIxJ2J5QooCdmVUKcQo7hTvXxQY+K4Eu4o7rr54vZESMP4Pdby
 NpbbCPAlXb3GbSvpts+aOK+yiJCRICMNEL8qyU3dTCoGThJPDJU4fGsG8eOpMULlqhecFkyaHTY
 ThZerKYaGot1B7HgN+QpEgiyTqsto6xaDSyY/UHx+qRGq1Hm8TT+nd0py8g+D6DZmjfsnObma09
 /OpRPG2zU8PB+VjiwujRyl7AneJbne2XzDvkkzDM1FmUz2JIO0Taak16FUUM+9oCYKITA/WbvtP
 zAKnS85rgiIw93MzdiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-25_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610250012
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
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IDZl
ODNkODY3MzNhLi4yZWJhNjAyMWI0YyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
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

