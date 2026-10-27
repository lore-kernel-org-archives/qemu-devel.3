Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6F606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i3sB/IwB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hfsngQNr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiJC-0007CV-0m; Tue, 27 Oct 2026 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ7-00079K-02
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xLiJ4-00060v-9x
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:37:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoMRJ858530
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=; b=i3sB/IwB9wAfOnQF
 ph4JSu01SbqMTrdrO47FRlvLOdzVM2yRAiaRwRIa7cMOu2+IK7WzLaBCpnQWAmWP
 yzkbvvnqcgumkL5WwZT3jMqpqFmpTukAkbdib5PJWEWZKOOZIqmEIoxkPBUW4LlA
 b05sB1KdnPIAdbcne9SNe2bRLQN8b0URra8qtobvLWfno+sXixJS3ryCPNqdzLDW
 rkXW9zAWqo66WRnGRNIrcpkkgm4Y7ODLJBRTfzy3dvz/rDzxS0f5Aq3lpEYIP+SD
 IMAtX2MAtlCMw6UWTXVei/3ehktNBnQ7/nYXH+ZjN2e9rs1aBUT4nvLFhaZqpIbp
 DS1VGw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54mapm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:37:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so3074716a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793111859; x=1793716659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=hfsngQNrMse7jWq/G0U62DISH7vGv/UOmr9mSLwLyGUPv1JAlmnmttE5VybbbCGTG5
 8Vcv3eKwiub0/5xdyliPzC3Ovk+NEl5Hy1XiMsCELP+T922NFXMHv5TaVQ2+/r1BURhL
 W+YHhM9uumQ7KOpJ1I/Q95kDWvkXWO6xJFNvtLenH6w6FXfECWnJGdVHObpISWAY6BKu
 unP6EDn81LaUKgXxfEw3zYQaD+/NlN4LjhPRw9Q5o4GGNOfQlggCWqUrHjR3IPrOX6LG
 9x+iN0C4eGr8PhTa4b0IkRh8i5kzAV8z6YzOWJChPbZsGl3xgYNSNRpSXp2qnzpvgf9u
 vHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111859; x=1793716659;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2cvTVzD7i/Dj3ZjXL/1YgmL/JijYtB2oiPHBNYiZkqM=;
 b=OIVIft+1Py5URul1xnUVjjIaOE4dQMFLRqE/ldGrIi17FLAh92CNFwnt+mXbVc0NTa
 ozZWJ7NkxoWsRynyEefgb2MdPzQn5bQiRMMRNZ2nH1ouB3aQ+YIWGj5s3/TUya66Hkog
 hlR8sykWXKEU3M57DdhzjWJ8g0DLKPXI1Rh+uIjr6XlWpVvY7WBxbuWcKLy1J1es73E7
 ZjZ5f8ro+aIh+/WIUHHLD67zqd0K4KgRMFj2M0ErOGM2FSvO/P8MGH1Y/pAnr76Giovp
 u2DKMX8hNV7w73q0rrBPfJCyacBLBKF7WnCtzOY6HOb8CsGcIcNQ7RRFlDQTV0UTdFCp
 SpHA==
X-Gm-Message-State: AFq9FYJ6WKWFr8gXVR3MfH/PzUbYbKm/Bj8Ok6yzEoUVnz5wBp9ZUBBg
 i91V9kaGWoFnUcMT9MvL6WvBJnpB8SPcRNM1odjgwiHKZ3pHyl3Kgv0YpB7VosbTT6OuoX/6HkZ
 dGM4n1Ma1OGq5bswzk9q0lByKzlFf3Dp+feB3iRZiuXq6NJiGlVHHKTEYY+uoK5caMw==
X-Gm-Gg: AYBFou1OsnSz7JkJi7/1qPKGgVHo6hpudwJmsGgX+2NWAorHPA3vsTm3K13oNxc8Y1p
 jZnkluvlN+J2jUemQH8dW6p5qs2/jix7yXkRrkA2remFLyphP+L6cpv+iGKq2t/1teVLhGgq9Vp
 Tu2O3+67N9drThOEkC0tbRKK2dIYA9F33OYUBWuohw0adPDCSUFh/SsbXD0p73lsXEmA5zNZmmp
 Jt8feBkzz7viN3X7frmYlvJ+QqrtETygPzNJ4y//YDgoWoiyuvn74fySWdch5mBzUuYm39dNgAM
 oItedbfnUIbg0/cU5hcxXeVyVVjP12dlHIjyz0mqqnrFOtbJfufQ6qvspaskIUDwlSpBw1lOnmW
 WUwk6RSneXvvLRJvUMqZPci9S3BiXOGTupuYHK883I3nLsm8=
X-Received: by 2002:a17:90b:1812:b0:3a7:9e3d:b3 with SMTP id
 98e67ed59e1d1-3adeafcd3damr8011728a91.66.1793111858536; 
 Tue, 27 Oct 2026 07:37:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1812:b0:3a7:9e3d:b3 with SMTP id
 98e67ed59e1d1-3adeafcd3damr8011709a91.66.1793111858086; 
 Tue, 27 Oct 2026 07:37:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae404dde70sm4056102a91.1.2026.10.27.07.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:37:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v4 05/42] Hexagon: add v85 CPU model
Date: Tue, 27 Oct 2026 07:36:44 -0700
Message-Id: <20261027143721.4125584-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
References: <20261027143721.4125584-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX0rEQjeBcKcGm
 xwNCVqEs8a9XbvkuRTYVGVntsQZN1H3cYxTNc+JL4PP30z2Oky1MEv2jgAbrqa073vSZe2xR9aI
 sybFxIlzZ4NbxVsEbxR/nI1jGQtbqkc=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0b733 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=6RDhHJMOdHl8aUYkYD8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: NeHoCdHTazUiV91Z6Iw9pxQG_60X94vS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXygpEz9hm5Hzc
 LiaZzVhrUM8BJp7ZJmE1KymWDfuhHL52+i5SlB1b8i+PEkVBPrkDw10v6/zYV6rllRfX2mbUM9X
 /ScAOGTfVLGGmjU3mi0HZAHUF7WXRGwLopdxIqLmxX4Dq6IUM1weJ2HohuyrSpP4Rd+rfIgATrA
 01gvK6dJHug4PVLZDGqufXPOTl9UKM0aFR0HmySPA/v1kMBsIA4h7fpKhxeBRGw3f2r2cVfRz8L
 zECt1aLiZ2N2OV4vMZbKBjq9ciG747w3vLAF+Y1ZP0wS7PckJyfMtSApAdoYjA5gB+3SdoUq2ux
 EtTmq+GEasVBbdCH3sHKmTKGNhc7LaU9gv3MzqxzRM0dVvyZLm/lCIR4vfMF5UtnV1hQr7W59eT
 ufgvb9oHrpGCdrjxQVECKf6vDpSSz7klRFRuP+OmZaH7xm5TtKGPbwlJ7ES1fDxZ4WM5qno6riH
 +low+jq5gcV7VJVuJ6A==
X-Proofpoint-GUID: NeHoCdHTazUiV91Z6Iw9pxQG_60X94vS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFs
Y29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxj
b21tLmNvbT4KLS0tCiBkb2NzL3N5c3RlbS9oZXhhZ29uL2VtdWxhdGlvbi5yc3QgfCAyICstCiB0
YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmggICAgICAgICAgfCA0ICsrKysKIGxpbnV4LXVzZXIvaGV4
YWdvbi9lbGZsb2FkLmMgICAgICB8IDQgKysrKwogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAg
ICAgICAgIHwgMiArKwogNCBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIv
ZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0CmluZGV4IDEyMzg1MzExYWE0Li5mYjU3
Yzc3YWU5MCAxMDA2NDQKLS0tIGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cisr
KyBiL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApAQCAtNiw3ICs2LDcgQEAgSGV4
YWdvbiBDUFUgYXJjaGl0ZWN0dXJlIHN1cHBvcnQKID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09CiAKIFFFTVUncyBUQ0cgZW11bGF0aW9uIGluY2x1ZGVzIHN1cHBvcnQgZm9yIHY2NSwg
djY2LCB2NjcsIHY2OCwgdjY5LCB2NzEsIHY3MywKLXY3NSwgdjc3LCB2NzksIHY4MS4KK3Y3NSwg
djc3LCB2NzksIHY4MSwgdjgzLCB2ODUuCiBJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUgZm9s
bG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgogCiAtIEhWWCAoSGV4YWdvbiBWZWN0b3Ig
ZVh0ZW5zaW9ucykKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaCBiL3Rhcmdl
dC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCAyYmZhNGQ1ZDBmYy4uZDRjODQxM2RlZDMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUt
cW9tLmgKQEAgLTI4LDYgKzI4LDggQEAgdHlwZWRlZiBlbnVtIHsKICAgICBIRVhfVkVSX1Y3NSA9
IDB4NzUsCiAgICAgSEVYX1ZFUl9WNzkgPSAweDc5LAogICAgIEhFWF9WRVJfVjgxID0gMHg4MSwK
KyAgICBIRVhfVkVSX1Y4MyA9IDB4ODMsCisgICAgSEVYX1ZFUl9WODUgPSAweDg1LAogICAgIEhF
WF9WRVJfQU5ZID0gMHhmZiwKIH0gSGV4YWdvblZlcnNpb247CiAKQEAgLTU1LDYgKzU3LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgewogI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y3NSBIRVhBR09OX0NQ
VV9UWVBFX05BTUUoInY3NSIpCiAjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjc5IEhFWEFHT05f
Q1BVX1RZUEVfTkFNRSgidjc5IikKICNkZWZpbmUgVFlQRV9IRVhBR09OX0NQVV9WODEgSEVYQUdP
Tl9DUFVfVFlQRV9OQU1FKCJ2ODEiKQorI2RlZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y4MyBIRVhB
R09OX0NQVV9UWVBFX05BTUUoInY4MyIpCisjZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjg1IEhF
WEFHT05fQ1BVX1RZUEVfTkFNRSgidjg1IikKIAogT0JKRUNUX0RFQ0xBUkVfQ1BVX1RZUEUoSGV4
YWdvbkNQVSwgSGV4YWdvbkNQVUNsYXNzLCBIRVhBR09OX0NQVSkKIApkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
aW5kZXggM2E2YmE0ZTEzMDQuLjlmOThhZDhmYjg2IDEwMDY0NAotLS0gYS9saW51eC11c2VyL2hl
eGFnb24vZWxmbG9hZC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMKQEAgLTEx
Myw2ICsxMTMsMTAgQEAgY29uc3QgY2hhciAqZ2V0X2VsZl9jcHVfbW9kZWwodWludDMyX3QgZWZs
YWdzKQogICAgICAgICByZXR1cm4gInY3OSI7CiAgICAgY2FzZSAweDgxOgogICAgICAgICByZXR1
cm4gInY4MSI7CisgICAgY2FzZSAweDgzOgorICAgICAgICByZXR1cm4gInY4MyI7CisgICAgY2Fz
ZSAweDg1OgorICAgICAgICByZXR1cm4gInY4NSI7CiAgICAgfQogCiAgICAgZXJyID0gc25wcmlu
dGYoYnVmLCBzaXplb2YoYnVmKSwgInVua25vd24gKDB4JXgpIiwgZWZsYWdzKTsKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZjM4
M2ZmZDg4ZTYuLmU3NzA5N2JlZmM4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYwor
KysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtOTc5LDYgKzk3OSw4IEBAIHN0YXRpYyBjb25z
dCBUeXBlSW5mbyBoZXhhZ29uX2NwdV90eXBlX2luZm9zW10gPSB7CiAgICAgREVGSU5FX0NQVShU
WVBFX0hFWEFHT05fQ1BVX1Y3NSwgICAgICAgICAgICAgIEhFWF9WRVJfVjc1KSwKICAgICBERUZJ
TkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjc5LCAgICAgICAgICAgICAgSEVYX1ZFUl9WNzkpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WODEsICAgICAgICAgICAgICBIRVhfVkVS
X1Y4MSksCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y4MywgICAgICAgICAgICAg
IEhFWF9WRVJfVjgzKSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjg1LCAgICAg
ICAgICAgICAgSEVYX1ZFUl9WODUpLAogfTsKIAogREVGSU5FX1RZUEVTKGhleGFnb25fY3B1X3R5
cGVfaW5mb3MpCi0tIAoyLjM0LjEKCg==

