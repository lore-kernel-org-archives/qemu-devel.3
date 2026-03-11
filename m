Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7BAFD88F4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0B3y-0006Tl-OX; Wed, 11 Mar 2026 00:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3h-0006Mk-Os
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0B3g-00032E-4m
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:20:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3AMRX2180799
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w4V8JTBIE3EXuNbVssomFJQ1Ffy0EuKH3o/8PO63JkY=; b=IMtWHsMzXK/Mq332
 3tzDLL6DYSjy0NSojhnO5zGEs8yUQCyiFDBMj669/GQOfCBlMdnzXlfcNnLgCvYV
 TiJFgG1cpSuTaaxwP9sn0JTd/QQCq2yuarz70xWUo1oW/GcmIOnAsmE+3oojrFDK
 GGlJ/bxVMkbDIYv5ejlUbygkFSmdXcuJT5Bt05l6czJbOclVGG8ZiXbFtDKDYqHJ
 fFr7urkSHXWODjZ4TMfRa35n/ypLX/uQQ9MJ6fYa3P4hU9KO6880vNjtadAB2+D1
 V+g2vdytU5D9LypPmqqNH3j0dXyW2S9AIc+sAAQe8ryO8w1y6rI811SInXriMu+/
 mX076g==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvssujs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:20:31 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7d7543bc61cso24312168a34.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202830; x=1773807630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4V8JTBIE3EXuNbVssomFJQ1Ffy0EuKH3o/8PO63JkY=;
 b=NOwPkK5UpCANKcrMo7vQ+KRf0ZYxXOTlLtmtgquCKjVqLirQWfWy0ZNK9gCFsg9fNy
 bFen7X3wX40jkfNRqbcox+tXV0fs6WMpa41bKwH0CTnfCDxzyBgjXlcDyocdSs3IaF47
 Ie5dnQDXxW2oiLwQgYNEwhBKtKA+k+/AMAwjKewjaOes02YFD2/rOEFb4x80aH4Slvm4
 Q8vt5u8hOH/G7JmJkSwKymY6/6ITsq0ipSFWOnq2ZB2soFRMlyo7DFwZ2+8PErELIDmX
 1XvA3unzt70aJrsY5ldc7wy0RyzRjnd89JnAucpReSytnopY0UNjJ/d6tOibdiJJgOak
 SmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202830; x=1773807630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w4V8JTBIE3EXuNbVssomFJQ1Ffy0EuKH3o/8PO63JkY=;
 b=UBg4XbLBR7Jz//Tum3hMsUUpZ/vtIoVVWj4hMFLjXpndDKFV9FtTH2k+I1Agw3Ur0p
 gS6CsFwXvxGtmCEewxpbqduZY2xV5cxYAuq9pJpehna51W7W5yhYDikfKfGx+4YLHUlG
 fi6TnHowz9p6/C9aEnF25PDNwhIN3iTH4KQEQWxeTm4mlhkLt5b93tfvZrHrQUlsz7i5
 dBgjd1cWB1Od5913SAYhkTvhBZOJrbSI22a3Xogh6rMLwAhHLNnOSykunfWy+N8gas+v
 DOef7a6K76YtYLkMlJ6DThezU4N7T50lmtz7owhRFSbaj5UtwZwttpFc5cJ+IhIsWjtt
 OZRQ==
X-Gm-Message-State: AOJu0Yx/Em9XwtyeEZ2+sxqnHljDWeX3dYDOs5TZljZ75JfFL8W/LaUc
 K+wtyKjT256gGhP2H7SDUOxRbtJP4O0h7kUqX5R0qVAKVmCZv4F8tUKXgQpOBWtrcW23JOA8csA
 Cie1DAixhq2AkBtW5vGFi5Xnb4BfQhWQ+7kCRmilYYSZiOtSYkyucvIolysN3mf/v1A==
X-Gm-Gg: ATEYQzyU4cV45kAcsDJkIbqVBEPitcsft9VGgMZENgKDt6K3+g+V50sp7KVcCuyurra
 BpN/zC/L9vTJ9Im7gf8Gfqxv0xCjrIhmEwsJifExmavNjZ58sb7iv5Iy/WFDCcXEFJzyjP2RJuR
 0Q2/2RQZgA/0jvndjsUH02iPlLAswfz2BPJ+SIzsS50AYixC6m+1BGEeUIvcSuSJsy80iFrAZRG
 4CGJ3pA/irBpQfFJ1YZOAjnEGvnEFq1HRYfmZt8TfxyytSaHbPmxktlA/fFrUWfCX7dUeESsg8d
 /qmm6nXqdr4+2g9trVQhavMFdznaRIQEgRLZ+suT15EN5a+u8LEl9KgftSe0iqpOfGcT7uFaPLB
 PSjgnyRDYOr5z8Ok2x0w8T1N/L41gaxiT5+hi+XFq5ed9+Q6Xf1SaHaBAzxI5TAORGrQEnQ==
X-Received: by 2002:a05:6830:3886:b0:7cf:cd98:b3c5 with SMTP id
 46e09a7af769-7d76a7a3f13mr977607a34.31.1773202830355; 
 Tue, 10 Mar 2026 21:20:30 -0700 (PDT)
X-Received: by 2002:a05:6830:3886:b0:7cf:cd98:b3c5 with SMTP id
 46e09a7af769-7d76a7a3f13mr977594a34.31.1773202830027; 
 Tue, 10 Mar 2026 21:20:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aeccd73sm892003a34.27.2026.03.10.21.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:20:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 6/9] hw/hexagon: Modify "Standalone" symbols
Date: Tue, 10 Mar 2026 21:20:16 -0700
Message-Id: <20260311042019.1085030-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
References: <20260311042019.1085030-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMyBTYWx0ZWRfX/iKwPWlDcC/b
 ++HCuTmyTnUi/QCODrxPprJWn3pJTyWeiRs5PgPm/Rtn54ZCKIfKVTyPwR4VfhuHXM5hIdyAw0v
 mGCwhHaad2GsXdZp4l5pLh+f7EoPfU5+jTMKNOLBZlCcPm2qyaeutczHK57CIUkT5wDMV4dqj7Z
 hDOZjHZPVHjNp6am1z3AdhCv2W5/L0HGkDK5EnMLCPjiAHm7Oyjd+12rROpN1IMazwb8XvQ6GbZ
 /DMTZP0ThQWvNNPfddqlE8NtaYKzH51kFNCzvY+WJwtDeBO5yMjVmMFYMkTHqlxwUiWLwOBisQJ
 XSJmQQftjN4WmOch3IswJF8BrDN3xM5NvDBCFKxkXhBJSJaBBvRFbmyMsS8NXT9/NtDzdO9ynkM
 AqKgDqjWuNCQwbvMCrHD1aYbVWJU3piJghcka82VofpMJZ4fiEaQzx6bjDbe2FkMs5td4xarwVN
 W0dDqtKQXWPIF0+b4Hw==
X-Proofpoint-ORIG-GUID: BZfaO4XYsuvQPn9bb59TlX4dboJ0lUDW
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0ed8f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=QhYL57-57G4zB7GrFpIA:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: BZfaO4XYsuvQPn9bb59TlX4dboJ0lUDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110033
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGVzZSBzeW1ib2xzIGFyZSB1
c2VkIGJ5IEhleGFnb24gU3RhbmRhbG9uZSBPUyB0byBpbmRpY2F0ZSB3aGV0aGVyCnRoZSBwcm9n
cmFtIHNob3VsZCBoYWx0IGFuZCB3YWl0IGZvciBpbnRlcnJ1cHRzIGF0IHN0YXJ0dXAuICBGb3Ig
UUVNVSwKd2Ugd2FudCB0aGVzZSBwcm9ncmFtcyB0byBqdXN0IGNvbnRpbnVlIGNydDAgc3RhcnR1
cCB0aHJvdWdoIHRvIHRoZSB1c2VyCnByb2dyYW0ncyBtYWluKCkuCgoKUmV2aWV3ZWQtYnk6IFRh
eWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hl
eGFnb25fZHNwLmMgfCAxNSArKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IDJhMTBhMmU0YjNiLi4zODYzZjAyMGU3NCAxMDA2NDQK
LS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9k
c3AuYwpAQCAtMjgsOSArMjgsMTcgQEAKIAogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y2NmdfMTAy
NC5oLmluYyIKIAorc3RhdGljIGh3YWRkciBpc2RiX3NlY3VyZV9mbGFnOworc3RhdGljIGh3YWRk
ciBpc2RiX3RydXN0ZWRfZmxhZzsKIHN0YXRpYyB2b2lkIGhleF9zeW1ib2xfY2FsbGJhY2soY29u
c3QgY2hhciAqc3RfbmFtZSwgaW50IHN0X2luZm8sCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQ2NF90IHN0X3ZhbHVlLCB1aW50NjRfdCBzdF9zaXplKQogeworICAgIGlmICgh
Z19zdHJjbXAwKCJpc2RiX3NlY3VyZV9mbGFnIiwgc3RfbmFtZSkpIHsKKyAgICAgICAgaXNkYl9z
ZWN1cmVfZmxhZyA9IHN0X3ZhbHVlOworICAgIH0KKyAgICBpZiAoIWdfc3RyY21wMCgiaXNkYl90
cnVzdGVkX2ZsYWciLCBzdF9uYW1lKSkgeworICAgICAgICBpc2RiX3RydXN0ZWRfZmxhZyA9IHN0
X3ZhbHVlOworICAgIH0KIH0KIAogLyogQm9hcmQgaW5pdC4gICovCkBAIC01OSw2ICs2NywxMyBA
QCBzdGF0aWMgdm9pZCBoZXhhZ29uX2luaXRfYm9vdHN0cmFwKE1hY2hpbmVTdGF0ZSAqbWFjaGlu
ZSwgSGV4YWdvbkNQVSAqY3B1KQogewogICAgIGlmIChtYWNoaW5lLT5rZXJuZWxfZmlsZW5hbWUp
IHsKICAgICAgICAgaGV4YWdvbl9sb2FkX2tlcm5lbChjcHUpOworICAgICAgICB1aW50MzJfdCBt
ZW0gPSAxOworICAgICAgICBpZiAoaXNkYl9zZWN1cmVfZmxhZykgeworICAgICAgICAgICAgY3B1
X3BoeXNpY2FsX21lbW9yeV93cml0ZShpc2RiX3NlY3VyZV9mbGFnLCAmbWVtLCBzaXplb2YobWVt
KSk7CisgICAgICAgIH0KKyAgICAgICAgaWYgKGlzZGJfdHJ1c3RlZF9mbGFnKSB7CisgICAgICAg
ICAgICBjcHVfcGh5c2ljYWxfbWVtb3J5X3dyaXRlKGlzZGJfdHJ1c3RlZF9mbGFnLCAmbWVtLCBz
aXplb2YobWVtKSk7CisgICAgICAgIH0KICAgICB9CiB9CiAKLS0gCjIuMzQuMQoK

