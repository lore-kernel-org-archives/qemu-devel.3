Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Hg5GT9Ym;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GowZMueo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvo2-0006zu-Gc; Tue, 24 Nov 2026 14:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvnf-0006o8-JX
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xVvna-0006hg-FJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:03:29 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXRW52752107
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lg0U9jwk775fHwLEnsmstK5SfnQyBvoO/ms66olZGvw=; b=Hg5GT9Ym1TBneHxl
 OQxsnkPg4lpv9oUs27xQwwXhck2qG2twsrwYCBKsv9TEhPbSSKWTTKfxpXUosks7
 BabWQ1IJPHp+hg93AVwGjpCHzbhfJn1Jh1dglOBQ/SUo7V1iyrzjMpORcJEF2JOD
 wTSfmqJHoS+WAyyLX26tgMVM3GKd1nTtGIxVxiothDhRugoSVffEZpXG0I0u0dQT
 8dkqe3lFljTd1lAc1GrNRXSvlTNGNfse4cUKIQWT7PSfocwONeiZkfHs+cmSi2ai
 JHl0pHbEuoDpufZypLbdYtKHDrEJY6WlJek2DBXcQ1us9K5Fu7tysOBm0sEguITS
 b6m4BA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yvd4jve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:03:25 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-57ce46ad0c1so2761756b6e.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547005; x=1796151805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lg0U9jwk775fHwLEnsmstK5SfnQyBvoO/ms66olZGvw=;
 b=GowZMueoT4idga7wqJIyvELPw9D9fcDetccdXarBGjTzVcKxJeu+RjS86huL7bhDd8
 y1QEraK9PJtOqyEUN+NOrooZyt1B3VaDO4CdLfmrkR7C0lGvbHuWzkBIpoZAsY18ajMW
 0oPApMXX+frf0y9kdbsFWRLUBnCOr0DGESP8+/USbhg80jOumO4YhsSeGaA3AKIqiDLR
 eA1IRMsfp1k3K3KTqdMCnO3XoUUzkQWtftHeYrZSI+Doq3wxhs9bKwF9yrzFWWvE82K1
 1/lbUnkHpl8xgfSXdFWLOxhTrnf8l3mnT51HOCRj/4+Nu6ftWBB0B0oGir+ZYN7cOwof
 KolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547005; x=1796151805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lg0U9jwk775fHwLEnsmstK5SfnQyBvoO/ms66olZGvw=;
 b=rD2ntRT9IERJen3t4dewG/Nq2urC/ENAeI9iFoDDgwandxhH+9Sakr9h3aK99WlgZE
 XP+JLvKLyr6PNq6+md5uZd/x/IN2M+Uh1FXrkcrlM6d2bpwBOF6zthXzHkjX8ML/tdNJ
 N21kgaqPxUNUu7O7bDGrJeXReHUDLOfiWAQspehAw8Hlkmoem1C3bsNYffCGAjTmaTs2
 CFRaZ3GpZWO/3C5p0T46ziC9AAVPCzNNYt0tZjhd/F1qLG0fjCXarTI7sCmve1vNQsny
 cgtuttry2PuMOUHe+DmvD9pdyiXHg6JCDKVPv5yvlFsKuLYW69YnOvv5KIBUdoU0dDYF
 KJjA==
X-Gm-Message-State: APuU4Z+XOViVRSmKFlwOlI6xBUzea0Nr4OBEk0E3y2IjtoVtIi3nOePQ
 Ee8awMIqOmPMqfDO6NSphnI4LLMV9C3+KdTowNEbR25QXiF43QOmbPjW2gKmuPwacxnATupicZX
 VAtjnKbCZkAhWcviJeszFExFWEfhKjc8x45J7pNCh1z56faRoa8QLfvSl+IsJg1Rxdg==
X-Gm-Gg: AZFdTZc2Lyh0FU4D770lOFJkGTvAn3PSXB9lptGybFkLft+LmF0/i4utx45F/DITP2O
 fbkzO4Ab09DDDQFXIxh+f3yoaJH7qSQH+YXcc2uZk7aJOo8PvtEj0wBAr4zAq85zN3y3Ov7ZiM1
 yKrqRGxcUdlK5ZaJmmiUKKqiyYg9FxCOAp9mDsPHprNhWdInUL76MqXcuO9bBgW6gkIw/8JpCxA
 TzvHQ8iWtOd7NugzzeMy8YpDGXHO6G2AHAMBHmPVrScDUERCghClnnjKp39RDRf2OZ/EPkYy6w3
 iJPyt/KHJna+nGGiKyXBsAiExDqJG1TNM9iwH+5SnpMowkKGVGFCCT0PrSqEvqjPwW5zvdjlnJy
 9Cxnoo4+5+ty+u6g93l8fzA5yEi3YP79t4YpjOdZMLqSydcVkSDKB8bGOODT9Kl/uWeBvyxP8Hz
 BaHEAjWXAU03mur38U4QvXnQ==
X-Received: by 2002:a05:6808:3a0d:b0:4d6:9252:48c9 with SMTP id
 5614622812f47-57a0c0a214cmr16130715b6e.53.1795547004687; 
 Tue, 24 Nov 2026 11:03:24 -0800 (PST)
X-Received: by 2002:a05:6808:3a0d:b0:4d6:9252:48c9 with SMTP id
 5614622812f47-57a0c0a214cmr16130665b6e.53.1795547004084; 
 Tue, 24 Nov 2026 11:03:24 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a31929223sm12343195b6e.1.2026.11.24.11.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:03:23 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH-for-11.2 v3 4/7] target/hexagon: deliver floating point
 exceptions after the packet
Date: Tue, 24 Nov 2026 11:03:11 -0800
Message-Id: <20261124190314.3882017-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6b05df7d cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=WGR0rWkjfx4cIdXbClMA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4ZJq++qGg507
 oFdjzwm+B+zgZF+tQMEHXMtxDkl8+1ghBxa4RjMXB6nhGmw9MPQS3wvdHOe/pyydMgUQ9i80Yqq
 7kHyXwyz0uooJqvTlp9bpEkHbG1KPvRQ+EWW2ux2gUkazFhXU+9ahZKyAcJ53SWl16enQHItsAi
 B+KoAalDuQcW+NFQnYpYFoTb3SQH5xJ0rDmceIuMPVjq1bOkVkX1LaZjXs4xtCj3QsSDBSAOsNp
 9cecM9hZkN4hL3seb/1oNr0mcdrdRHwoyzrdwYlnKB6+ZBanydjcLo+dmgzYLoYzl3QOoWNYdn9
 IdZSoh/oWYhWq3btWbGYYwTJiiuiOrhXYtOSpWg3BHni+IINUD9n4hqcWT8qroNTM3M8dkcah0/
 to0zpE6PdSR4fCT5RSq6lVwiyYkbJZA1lcFrXpTqbuPuMr8yUBolH6n3Iv3k9KJ0wKqJXCpxkcb
 StzSeFABc9dENm2clHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX/HfyGhphHM9J
 opiG8ZYGKK2h67ByfmfOTaUL/kgjelPMkbHKaLsrqMsfFfs+hP8nHxn3QBA2DUtZMAZbwIna1Fa
 U3VGmetJsYggc2L4wyTiBFnBd5KGqFU=
X-Proofpoint-ORIG-GUID: x72m9aPhiuuSVYV9O21UMSfNdEuMxVAC
X-Proofpoint-GUID: x72m9aPhiuuSVYV9O21UMSfNdEuMxVAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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

QW4gdW5tYXNrZWQgZmxvYXRpbmcgcG9pbnQgZXhjZXB0aW9uIHVzZWQgdG8gdGFrZSB0aGUgZXhj
ZXB0aW9uIGluIHRoZQptaWRkbGUgb2YgdGhlIHBhY2tldCwgd2l0aCB3aGF0ZXZlciBQQyB3YXMg
bGFzdCB3cml0dGVuLiAgVGhlCmFyY2hpdGVjdHVyZSB0YWtlcyBpdCBhZnRlciB0aGUgcGFja2V0
IGNvbW1pdHMsIGxpa2UgdHJhcDAsIHNvIHBlbmQgaXQKdGhlIHdheSB0aGUgVExCIHBlbmRzIGFu
IGltcHJlY2lzZSBleGNlcHRpb24gYW5kIHJhaXNlIGl0IGF0IHRoZSBlbmQgb2YKdGhlIHBhY2tl
dC4gIFJlcG9ydCBFTFIgYXMgdGhlIGxhc3Qgd29yZCBvZiB0aGUgcGFja2V0IHNvIHRoYXQgYSBo
YW5kbGVyCnJlc3VtZXMgYXQgdGhlIG5leHQgcGFja2V0IGJ5IGFkdmFuY2luZyBFTFIgYnkgb25l
IHdvcmQuCgpUaGlzIGVuYWJsZXMgdGhlIGZsb2F0X2V4Y3Agc3lzdGVzdC4KClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQv
aGV4YWdvbi9hcmNoLmMgICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKysrLS0tLQogdGFyZ2V0
L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAgICAgICAgICAgfCAgMSArCiB0YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8IDEwICsrKysrKysrLS0KIHRlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IHwgIDUgKysrKysKIDQgZmlsZXMgY2hhbmdl
ZCwgMTkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9hcmNoLmMgYi90YXJnZXQvaGV4YWdvbi9hcmNoLmMKaW5kZXggNWVlODdiMzIwYjYu
LmRkYmNiYTljZGQwIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9hcmNoLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vYXJjaC5jCkBAIC0yMTQsMTMgKzIxNCwxNCBAQCB2b2lkIGFyY2hfZnBvcF9z
dGFydChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAqLwogI2RlZmluZSBSQUlTRV9GUF9FWENFUFRJ
T04gICBkbyB7fSB3aGlsZSAoMCkKICNlbHNlCisvKgorICogRmxvYXRpbmcgcG9pbnQgZXhjZXB0
aW9ucyBhcmUgdGFrZW4gYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IGNhdXNlZCB0aGVtCisgKiBjb21t
aXRzLCBzbyBwZW5kIHRoaXMgb25lIGZvciBjaGVja19pbXByZWNpc2VfZXhjZXB0aW9uKCkuCisg
Ki8KICNkZWZpbmUgUkFJU0VfRlBfRVhDRVBUSU9OIFwKICAgICBkbyB7IFwKLSAgICAgICAgQ1BV
U3RhdGUgKmNzID0gZW52X2NwdShlbnYpOyBcCi0gICAgICAgIGNzLT5leGNlcHRpb25faW5kZXgg
PSBIRVhfRVZFTlRfRlBUUkFQOyBcCisgICAgICAgIGVudi0+aW1wcmVjaXNlX2V4Y2VwdGlvbiA9
IEhFWF9FVkVOVF9GUFRSQVA7IFwKICAgICAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0NBVVNF
X0ZQVFJBUF9DQVVTRV9CQURGTE9BVDsgXAotICAgICAgICBkb19yYWlzZV9leGNlcHRpb24oZW52
LCBjcy0+ZXhjZXB0aW9uX2luZGV4LCBcCi0gICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYt
PmdwcltIRVhfUkVHX1BDXSwgMCk7IFwKICAgICB9IHdoaWxlICgwKQogI2VuZGlmCiAKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
aW5kZXggYWNjNjhhYTZjMjMuLjk2ZDRhNzgzZWQ0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9oZXhzd2kuYworKysgYi90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwpAQCAtOTcyLDYgKzk3Miw3
IEBAIHZvaWQgaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykKICAgICAgICAg
YnJlYWs7CiAKICAgICBjYXNlIEhFWF9FVkVOVF9GUFRSQVA6CisgICAgICAgIGVudi0+aW1wcmVj
aXNlX2V4Y2VwdGlvbiA9IDA7CiAgICAgICAgIGlmIChldmVudF90b19ndWVzdChlbnYsIENDUl9H
RUUpKSB7CiAgICAgICAgICAgICBndWVzdF9ldmVudF9lbnRyeShlbnYsIGVudi0+Y2F1c2VfY29k
ZSwgZW52LT5ncHJbSEVYX1JFR19QQ10sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
RVhfR0VWQl9IV19GUFRSQVAsIGZhbHNlKTsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggNzk2ZDMyYmZmOTUu
LjI0NjFiMDA2NGEyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYworKysg
Yi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwpAQCAtMTM0NSwxMSArMTM0NSwxNyBAQCBzdGF0
aWMgdm9pZCB1cGRhdGVfZXhlY19jb3VudGVycyhEaXNhc0NvbnRleHQgKmN0eCkKICNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQogLyoKICAqIEEgdGxicCBpbnN0cnVjdGlvbiBtYXkgZGV0ZWN0IG11
bHRpcGxlIFRMQiBtYXRjaGVzIGFuZCBzZXQgYSBwZW5kaW5nCi0gKiBpbXByZWNpc2UgZXhjZXB0
aW9uLiAgUmFpc2UgaXQgYWZ0ZXIgdGhlIHBhY2tldCB0aGF0IHJhbiB0aGUgdGxicC4KKyAqIGlt
cHJlY2lzZSBleGNlcHRpb24sIGFuZCBhIGZsb2F0aW5nIHBvaW50IGluc3RydWN0aW9uIG1heSBz
ZXQgYSBwZW5kaW5nCisgKiBmbG9hdGluZyBwb2ludCBleGNlcHRpb24uICBSYWlzZSB0aGVtIGFm
dGVyIHRoZSBwYWNrZXQgdGhhdCBjYXVzZWQgdGhlbS4KKyAqCisgKiBBIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbiBlc3RhYmxpc2hlcyB0aGUgZXhjZXB0aW9uIHBvaW50IGFmdGVyIHRoZQorICog
cGFja2V0LCBsaWtlIHRyYXAwLiAgRUxSIGlzIHRoZSBsYXN0IHdvcmQgb2YgdGhlIHBhY2tldCwg
c28gYSBoYW5kbGVyCisgKiByZXN1bWVzIGF0IHRoZSBuZXh0IHBhY2tldCBieSBhZHZhbmNpbmcg
RUxSIGJ5IG9uZSB3b3JkLgogICovCiBzdGF0aWMgdm9pZCBjaGVja19pbXByZWNpc2VfZXhjZXB0
aW9uKERpc2FzQ29udGV4dCAqY3R4KQogewotICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwo
Y3R4LT5wa3QucGMpOworICAgIFRDR3YgUEMgPSB0Y2dfY29uc3RhbnRfdGwoY2hlY2tfZm9yX2F0
dHJpYigmY3R4LT5wa3QsIEFfRlBPUCkgPworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y3R4LT5uZXh0X1BDIC0gNCA6IGN0eC0+cGt0LnBjKTsKICAgICBUQ0dMYWJlbCAqbGFiZWwgPSBn
ZW5fbmV3X2xhYmVsKCk7CiAKICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfRVEsIGhl
eF9pbXByZWNpc2VfZXhjZXB0aW9uLCAwLCBsYWJlbCk7CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBiL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdv
bi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IDc2ZTI0ODBjMWQzLi42MDY1NjcyMzBiOSAxMDA3NTUK
LS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKKysrIGIvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTgyLDYgKzgyLDExIEBA
IGRlZiB0ZXN0X2Z0cnVuYyhzZWxmKToKICAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChvcy5wYXRo
LmdldHNpemUoZnRydW5jX3BhdGgpLCAxLAogICAgICAgICAgICAgICAgICAgICAgICAgICJfdGVz
dGZpbGVfZnRydW5jIHNob3VsZCBiZSAxIGJ5dGUgYWZ0ZXIgZnRydW5jIikKIAorICAgIGRlZiB0
ZXN0X2Zsb2F0X2V4Y3Aoc2VsZik6CisgICAgICAgICIiIlVubWFza2VkIGZsb2F0aW5nIHBvaW50
IGV4Y2VwdGlvbnMgYXJlIHRha2VuIGFmdGVyIHRoZSBwYWNrZXQKKyAgICAgICAgdGhhdCBjYXVz
ZWQgdGhlbSBjb21taXRzLiIiIgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImZsb2F0X2V4
Y3AiKQorCiAgICAgZGVmIHRlc3RfYWNjZXNzKHNlbGYpOgogICAgICAgICAiIiJhY2Nlc3MgY2hl
Y2tzIFJfT0t8V19PSyBvbiBfdGVzdGZpbGVfYWNjZXNzLiIiIgogICAgICAgICB0ZXN0ZmlsZSA9
IHNlbGYuc2NyYXRjaF9maWxlKCJfdGVzdGZpbGVfYWNjZXNzIikKLS0gCjIuMzQuMQoK

