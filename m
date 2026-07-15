Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D10C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4nA-0002jv-Da; Wed, 15 Jul 2026 14:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4n8-0002jj-T7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4n6-0005xB-J5
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBF8F204279
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=G7V2c3J23qtBaufFLjwb5s
 XPH/MQ8eoYTercBtJzqxI=; b=NnaQv8wDUeCMCespZlg6ZLGIL05WraFN2oLflZ
 tsMZjcBCxYpRbPmRU3ihAmdXhw+M4kJeoc4996m8G1YdVZ4vBW/37LMt9HTQua3y
 bC4UKbIqYAHRaSNYH20Cfa60fGo8GZ/XgG0b717dzdWZ6Nh/i5hWfGdE92fRcI/Y
 Wyc+u/PjLX36VhgLUsZiONOqz9BR5aUG9obzbP9TM203J81MVSWUT9PBXBDoLKmk
 HVurASxai+9GDejYrSLHLGsb54fK1la5XNcQAfWdt+O8LV8FOCqyIC/YNqriJ8Yp
 dczT22ZyPqM8TU3Dxqpo3tIr5GqCQ0MzVK0ZqGFkXfJ7ELzQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfhgjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2238444a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784141823; x=1784746623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G7V2c3J23qtBaufFLjwb5sXPH/MQ8eoYTercBtJzqxI=;
 b=c1enzSQYMD1AMDDHyKGH9+VwP0KUx/najKcVgJxSOjxGGBy5RK/f+kakiCeAb4EzHr
 86X4lAlASMALCyF3Rphj8cvPmACms9jLkMSUJRc24h7lY1Vfe/4Sn5Z7LQbwXvPWnjNO
 Gp17Ey4wgM8Z2mxd+cFSyceEOiFd9WUu4BDRPsQNTXZMLv2R3rerKNYoEHAq9heqvGTs
 yYI5BzL51EiSKc2LhjyTH+ciwEyf8enP0zLF9rY0LKwWOgHU+YaYYOxz1Ay66sdT7MLa
 uX8dHtl/9ivkkx10FUlsT/q4w+UMhMwkT/+m0d/myLaKd09dj6SSWU1MxIikCdZMD27w
 Lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784141823; x=1784746623;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G7V2c3J23qtBaufFLjwb5sXPH/MQ8eoYTercBtJzqxI=;
 b=lO+eMTXhlCfsf6lYr63fQ5yWkH3VMxS4mPVfeygXIu2gmrDXzQFNLxlnBTwPWrzynv
 OhH192ZJz/A/4tUMn47AUh9bH3JokSjh+a3y5pNGpHqpygozJiy36AGTYYIYZIEU96Ch
 haeMzyomKOj4ax/2wnBdIQ96qUbxQIwfNPd4JB5P+dEWem97XLzInOo9aW3n9i6DeGeq
 TDvGkOuHkj6+fQVH0A0Fa8IDKgU3FhSJ5AX+TYWhZX1tdLIWerzgTV2ALk1JsjCmZ7mn
 d2uRpHTfxV65eTa2KFnSzLhzOCagP3jCUuC5MgOrnPJGfUr2uj2ML/NOb7cSKnImwOYW
 gamg==
X-Gm-Message-State: AOJu0Yy9noInkslYnFNTdmvlcbVNjW09ht3cOouJU9v/GBD1OKvQtqxb
 ZTtyduU8YAbOJUJmVcg089T8WHfAlKpKZRidyFAiZ49iAaLt7eM/B3VkpW8a3dYRqytTMB3N/YD
 zmlRimloGqUqSzrLyxzvkGCRpqXq7tTUzezpwalu0LSoU41bcE3ZIBUQOCuVQm4XPsw==
X-Gm-Gg: AfdE7ck/u6lWANBZkiJgFl3nl6atph8PtESFgh3ZaAtJJQtI7hqEJVLtdL+pWZSRVpV
 nqUFFvvic9l8nixJLi+YiXbYzLAoZRAfum1rGkM0OsexunSoBDPaCUG3Mg8G25Ga49PMqTBcolM
 Wd3spTy+Dj+7xg1jvZuchMcHnvNpAWUEPK8l4jjQO+DJziWqRPuFVnVqZZPV5UB1fvt7hII0acW
 q7Vvko3t9+3RbuB091uH3qd0fFwjrpYVjEXkRELpZpqHo3hv3ztrV5lDrRcrwLvmSE1FNZisVL3
 9HnHHSa8df6BrhWl6erDHAOq55Hg47JMzUtdgVimKMyU90AzcsAxzPeC6B0HljKGTbR9SIpPq4B
 1BpePCRLGTJ09jaQkAWGnuOz4YUmN6bXw3yRDCCvRDgm8rnpAYx89CUT3m8I=
X-Received: by 2002:a05:6a20:3d1a:b0:3c1:817:7938 with SMTP id
 adf61e73a8af0-3c110b1e47bmr22644965637.67.1784141823384; 
 Wed, 15 Jul 2026 11:57:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1a:b0:3c1:817:7938 with SMTP id
 adf61e73a8af0-3c110b1e47bmr22644939637.67.1784141822823; 
 Wed, 15 Jul 2026 11:57:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm5469546eec.25.2026.07.15.11.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:57:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, matheus.bernardino@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 0/7] Add hexagon l2vic device
Date: Wed, 15 Jul 2026 11:56:54 -0700
Message-Id: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Pl03VTzj2XaIl3eeeu89xay_DH3aFXwf
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a57d800 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dBR0pReTuG5vc_x2so0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX8O3kswUfAlFb
 gjjNNsV4kT5LpjOlhvqRJWX3BaOB6mZDlQ9Lqg9hj2IhLoS3fdK+n1fCXHgGXJHNqnvsKwfcjXm
 yIdjCBIU+ipv+W5Cf4bs7lS4Rfvrv12HJgHyeD2mrxLVOjoXJH/QDjeN3OyyqjSVCr/3jHQB+/r
 gqx2ZKK9kLlaoHoKT24FR1445KLFhiBVVcOHuFrFchIqkNMe0T1DLxqqtmkULaec+HgRfmeYjPM
 vVHp+8HR8I+9rw2f9EYMNfns6SQHBoLDC7Y+1OUWwTjTulLx/GR2KoRdHgO76aXm3UDPWh3Wj/1
 v/i7GUoVtuDNNjjvw/IlRl64HmNUDFugrRiQzvsIGNHVGoFyKXKHXBn6JimX5NvmcN/SuR2d28v
 gle7aUtIEDKsBrSZB6gTmmWuYHn2kG3Z09gRvsWIHVFEDlkulTFbkBRObyIT84bP+WJRLnjV+kj
 QDnRog+koOhZbiFwd0Q==
X-Proofpoint-ORIG-GUID: Pl03VTzj2XaIl3eeeu89xay_DH3aFXwf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX5uQr8C3DSx2T
 ZO81dThLPwJxs2fm1HmqxiZbJLPgNduU4g5PRb/6Y7i6mG1hDaB9CtaFIidgIgsfir3XnuDMrgP
 AEo9fprYSIfIBlt9rtZM2tXQxEDx78E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150188
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

VGhpcyBpcyBhIGZvbGxvdy11cCB0byB0aGUgcHJldmlvdXMgc3lzdGVtIGVtdWxhdGlvbiBzZXJp
ZXMgd2hpY2gKaW50cm9kdWNlZCBoZXgtbDJ2aWMuICBUaGUgZGV2aWNlIGltcGxlbWVudGF0aW9u
IGhhcyBiZWVuIHJld29ya2VkCmFuZCBzaG91bGQgYWRkcmVzcyB0aGUgZmVlZGJhY2sgZnJvbSBw
cmV2aW91cyB0aHJlYWRzLgoKQ2hhbmdlcyBzaW5jZSB2MToKLSByZWZhY3RvcmVkIGwydmljX3ty
ZWFkLHdyaXRlfSB0byB1c2UgYSB0YWJsZQotIGNoYW5nZWQgYXJjaCB0ZXN0cyB0byB1c2UgUWVt
dUJhc2VUZXN0LnNjcmF0Y2hfZmlsZQoKdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjAyNjA3MTQxNTUxMjYuMzUwOTU0NC0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bS8KCkJyaWFuIENhaW4gKDYpOgogIHRhcmdldC9oZXhhZ29uOiBpbml0aWFsaXplIGRlZmVycmVk
IHNyZWctd3JpdGUgdGVtcHMgdG8gY3VycmVudCB2YWx1ZQogIHRhcmdldC9oZXhhZ29uOiBmaXgg
UEMgbm90IGFkdmFuY2luZyBmb3Igbm9uLUNPRiBUQi1lbmRpbmcgcGFja2V0cwogIGJpdG9wcy5o
OiBBZGQgZmluZF9maXJzdF9iaXQzMigpCiAgaHcvaGV4YWdvbjogY29ubmVjdCBsMnZpYyBkZXZp
Y2UKICB0ZXN0cy9xdGVzdDogYWRkIEwyVklDIHF0ZXN0CiAgdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uOiBhZGQgYXJjaF90ZXN0cyBmdW5jdGlvbmFsIHRlc3QKClNpZCBNYW5uaW5nICgxKToKICBo
dy9pbnRjOiBBZGQgbDJ2aWMgaW50ZXJydXB0IGNvbnRyb2xsZXIKCiBNQUlOVEFJTkVSUyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA1ICsKIGRvY3MvZGV2ZWwvaGV4YWdvbi1s
MnZpYy5yc3QgICAgICAgICAgICAgICAgfCAgNTUgKysKIGRvY3MvZGV2ZWwvaW5kZXgtaW50ZXJu
YWxzLnJzdCAgICAgICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb24u
aCAgICAgICAgICAgICAgICB8ICAgMSArCiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl9nbG9i
YWxyZWcuaCAgICAgIHwgICA0ICsKIGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2aWMuaCAgICAgICAg
ICAgICAgICAgfCAgODcgKysrKwogaW5jbHVkZS9xZW11L2JpdG9wcy5oICAgICAgICAgICAgICAg
ICAgICAgICB8ICAzMCArLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgICAg
IHwgICAzICsKIGh3L2hleGFnb24vaGV4YWdvbl9kc3AuYyAgICAgICAgICAgICAgICAgICAgfCAg
MjAgKwogaHcvaGV4YWdvbi9oZXhhZ29uX2dsb2JhbHJlZy5jICAgICAgICAgICAgICB8ICA0MSAr
LQogaHcvaGV4YWdvbi92aXJ0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMiArCiBo
dy9pbnRjL2hleC1sMnZpYy5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTMyICsrKysrKysr
KysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICsKIHRhcmdldC9oZXhhZ29uL2dlbnB0ci5jICAgICAgICAgICAgICAgICAgICAgfCAg
MTQgKy0KIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAgICAgICAgICAgICAgICAgfCAgMjEg
Ky0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICAgICAgfCAgNTYgKyst
CiB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMgICAgICAgICAgICAgICAgICAgIHwgMjQyICsrKysr
KysrKwogaHcvaGV4YWdvbi9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
CiBody9pbnRjL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsKIGh3
L2ludGMvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKwogaHcvaW50
Yy90cmFjZS1ldmVudHMgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArCiB0ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgIHwgICA1ICsKIHRlc3RzL2Z1bmN0aW9u
YWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCAgNjMgKysrCiB0ZXN0cy9mdW5jdGlvbmFs
L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgIHwgICAxICsKIHRlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIDI2IGZpbGVzIGNoYW5nZWQsIDExODcg
aW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9k
ZXZlbC9oZXhhZ29uLWwydmljLnJzdAogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaW50
Yy9oZXgtbDJ2aWMuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L2ludGMvaGV4LWwydmljLmMKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xdGVzdC9sMnZpYy10ZXN0LmMKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKIGNyZWF0ZSBtb2RlIDEw
MDc1NSB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CgotLSAKMi4z
NC4xCgo=

