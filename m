Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3E2C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH2JY-0000yM-CY; Wed, 14 Oct 2026 12:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2JV-0000yB-M4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH2JS-0001Ym-BW
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 12:58:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbErV301147
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=C6VY9fscd/NevcEpsu2Rlk
 vcCh9NSBjHDYbuKWJ9FLc=; b=Qo8S6iNj7TfSRnRgp1fVP+0x1DvW9ua4VyawZe
 o3L8z9YuEeGChrfKxDuwq+dJwfS2piKN1zeYnCxfBKU0Q5jTVHt0zxKcYeaOhS8O
 BL11lW7JzuGLgnvUtpP62ZQHPh3RXF8fOlAV4ewJ2kBIX/wYJMiGiwRU8PGNT2xO
 OGnnHmprnrwmSaxgf4yeim7jfa///EsuxdH2UoKcUAtoKurSU1OSDler79nnl+Pi
 w4iPb8UKy0g9ZutbV0oHAzFtstgA+KsEjk62pXAfrvWy+PhQSscYXwUKFNxKnlld
 ENui1977q8dQmPvlRUqgNZSvoBY8KehHAnwIWW6BbGQdqOMg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622nb8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:58:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso9374183eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791997121; x=1792601921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C6VY9fscd/NevcEpsu2RlkvcCh9NSBjHDYbuKWJ9FLc=;
 b=fZK1QZ4aGlkt/lVs//YAo8fvkYumqVFg8FMvGTjDImYakDj2PqGh3eXmDJz+/rv1i6
 Ooul18VIyOb60HqyDGieJLTpHwG2yY4EHd9DnMI25wZBmDuBISQzf1NfBShFHdfCKVck
 ZaJZZqTcXVW/bnpqb0r1tyxGLDccxJ3Du4UOK7goUEVrEDNfa40GPQJ0HXsuuGp5K0NM
 FMvUrawyOvbG0uEEkMQYLY3eNOdNmgIInKk8ojanTOW+Z9Qgm24vQ/AgGGA5GYxudLVW
 JX0ECXJBkbWMigBOoRyMOuD9Y5qG195HpV8SCPkYQq26vhGjr6FYgkJpu3BdumN2E/ml
 ll+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791997121; x=1792601921;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=C6VY9fscd/NevcEpsu2RlkvcCh9NSBjHDYbuKWJ9FLc=;
 b=jLFBgDhyg/0UA8HuucHw2X1f84l1IkTruROKlCy2u/qnTlOfkfj/WDsIbRnYKf3YEH
 8NQNsxTbzpWdOdu3V17Ix7dZ42oR6c9fiLfvQn0OV4VvAuIvfkskalFXzdX8e0bL4WbA
 uWTiSr8k1LvJIw0Q+mZ79dAWFNZx33/RfnRV8Vkayfpmio/ilE3QSbbjM8aFVklUXZIa
 tPHae9Z+KKQPIe5wA7nXo/z6pMepN8FPY705OVvlCGmOULLQkutyTEt3Njzl2nM/6xjH
 0CPQNG2pOnfL+1lWaT0kbvfMCLZq17ZNqnyO96LSI19UJN0ICJkLfDXDZBocq0LuyC9h
 Y/uA==
X-Gm-Message-State: AFq9FYJL2i1T/aCsMdvbvUavJhSYvQObo5yunbtZgWDSaY3a5sm7taHj
 UG394Qh71+XKvPVciH/9J5aJTg6BDmxW0Ou7xcylu9u5Idb+reI6Yglp2p+Ap8fymXdPlCGr+fX
 weVACPUVTNHum7FPHe0pLqukdgXjaKfuxmNefTrC/iSPXwElveGUWoa+1+vT1U/zQzQ==
X-Gm-Gg: AYBFou1i0KxhDhJNb34Q/Q1Ka/FANm3H/fPFBHRiLOFgA2rq2UvDvmWyNo9ndSu3Y8M
 hVGtT0gvjT3WByKCJK9VHSrORTLpLESVAHbVkTGKnckznRo3tXeDamEyR1ufD7lU5qWQLRv2965
 lvVug98Uc36FSWBMKB2kAhwC8ByF+9o6sOkMQ0EwinLpYWPi+SDGjHbfREXCHVhHFaqODprJ2QO
 1gl/BpEMIcY6DnSdvgnmQphKlXjJ3KXJ88zc21DRmERzreQ32eLeXcp8Z9T6Q7qi3FVKzteyLjX
 whSVnUCy77+XpUyT/xNaT5JImuyRjnz5wvhK/+gn3k7DmrrDGYn/Gvbj6qZKmSLXkmCHoXMPell
 5pYqBdtiWNSWZ/zyAjBCiulrZijnlx2eV/ZRJow8kIlNnZgU=
X-Received: by 2002:a05:7022:1709:b0:14b:1e78:a19f with SMTP id
 a92af1059eb24-16a56e87992mr22272863c88.6.1791997120541; 
 Wed, 14 Oct 2026 09:58:40 -0700 (PDT)
X-Received: by 2002:a05:7022:1709:b0:14b:1e78:a19f with SMTP id
 a92af1059eb24-16a56e87992mr22272815c88.6.1791997119841; 
 Wed, 14 Oct 2026 09:58:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-17dc865cbffsm11137939c88.6.2026.10.14.09.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:58:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/5] Hexagon: fix lock, priv bugs
Date: Wed, 14 Oct 2026 09:58:32 -0700
Message-Id: <20261014165837.2916482-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: sTRD4jPfYQOaH-KpENNUxKL21Fm3s4np
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX/x/lVz0L0s/7
 zNWLoBg7KfO8LXmxXSg74JKZy066E7SbPewqu21OSzvhoG3sxfh6V7+3uwJrDfkvYxvBCxzrXju
 w3R2Nn2WOpt7hYRqmyYd/AJQL4Jcmqb1dAwsCiRfsADUViiIsrgqy/PPhK3HSk0VqsNmQ1u82tI
 DCseAuuIpyO6vqW9VdWpOVeLkwT2tjMs1krMVJhVSBKdcYHf5MbzXkNqwDMk8tWxu3Y4CUL+7uh
 e3SeEkUCnkzeRmT6Yv/1YnYhUdqQ8rkz1mzr8YZLk7Zc7Ic91dYQXurIr5KG4Qqms+57GsIG1CW
 TqJMKbczOJY/sFVwKoKcGo3ah6Cl5N8Cow6G/FJ5wxlb7aitp8wsn8/BS1znYOksjUNkC0cmo+n
 V1mgIL9a1xHrQhVtgPXxYweFGsxwFN8MoNatNo1uj2Ksobx//7mWPNMyzqlYGS2LYWGD6Et42ED
 ssq4XK5gbMpTYsuIngQ==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfb4c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vnDRBMZamB5ZYofm1CEA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NyBTYWx0ZWRfX7/1U2H4Bn/K/
 FufOCZvWqrJ1WQH3QwgkY8zWWZDWjvy+SDghMkU3UFlDZOCk1lvA4jdVDSxeQPIt9a7qa3NvpRz
 Zhne2wdYP/WZJd0FO3RwXCRFsHWyFxE=
X-Proofpoint-GUID: sTRD4jPfYQOaH-KpENNUxKL21Fm3s4np
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140067
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

VGVzdGluZyB3aXRoIGgyIGFuZCBsaW51eCBoYXMgdW5jb3ZlcmVkIHNvbWUgYnVncyBpbiB0aGUg
d2F5IHRoZSBsb2NrcyBhcmUKaW1wbGVtZW50ZWQgYW5kIHByaXZpbGVnZWQgaW5zdHJ1Y3Rpb25z
LgoKTm90ZSB0aGF0IHRoaXMgd2lsbCBiZSByZWJhc2VkIHRvIG1ha2UgYWRqdXN0bWVudHMgd2hl
biB0aGUgKm5leHRfcGMgcmVtb3ZhbHMKbGFuZC4gIFNlZSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzIwMjYxMDA4MjExMDA1LjE4NTM1NDItMS1icmlhbi5jYWluQG9zcy5xdWFs
Y29tbS5jb20vCgpJbiB2MjoKLSBub3cgcmViYXNlZCBhZnRlciAqbmV4dF9wYyBzdGF0ZSByZW1v
dmFsLCBoZXhfdGxiX2xvY2soKSBub3cgcmVjZWl2ZXMgdGhlCnBhY2tldCBQQywgcmVjb3JkcyB0
aGF0IFBDIGJlZm9yZSBoYWx0aW5nIHRoZSBDUFUsIHRoZW4gZXhpdHMgVEIuCi0gbWluaXZtIHRl
c3Qgbm93IHByZXNlcnZlcyBzcGFyc2UgdGVzdF9tbXUgZmlsZSBpbiB0aGUgYXJjaGl2ZSwgc28K
ZXh0cmFjdGlvbiBpcyBmYXN0LCBkaXNrIHNwYWNlIHJlcXVpcmVkIGlzIHNtYWxsLiAgUmVtb3Zl
ZCBza2lwQmlnRGF0YVRlc3QKZmlsdGVyIGFuZCBzdWJUZXN0KCkgaGFjay4KCnYxOiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjYxMDA5MTkyNTQxLjQxNjM3NTgtMS1icmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICg1KToKICB0YXJnZXQvaGV4YWdv
bjogY2hlY2sgcHJpdmlsZWdlIG1vZGUgZm9yIHN5c3RlbSBpbnN0cnVjdGlvbnMKICB0YXJnZXQv
aGV4YWdvbjogd2FrZSBLMCBhbmQgVExCIGxvY2sgd2FpdGVycwogIHRhcmdldC9oZXhhZ29uOiBo
YWx0IG9uIHRsYmxvY2sgd2hlbiB0aGUgVExCIGxvY2sgaXMgY29udGVuZGVkCiAgdGFyZ2V0L2hl
eGFnb246IHNldCBhIHN0YXJ0ZWQgdGhyZWFkJ3MgZW5hYmxlIGJpdCB3aGVuIHN0YXJ0IHJldGly
ZXMKICB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb246IGFkZCBNaW5pVk0sIGxvY2sgdGVzdHMKCiB0
YXJnZXQvaGV4YWdvbi9jcHUuaCAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKIHRhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24v
Y3B1LmMgICAgICAgICAgICAgICAgICAgICAgfCAgMiArCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVs
cGVyLmMgICAgICAgICAgICAgICB8ICA2ICsrKwogdGFyZ2V0L2hleGFnb24vaGV4X2ludGVycnVw
dHMuYyAgICAgICAgICAgfCAgOCArKystCiB0YXJnZXQvaGV4YWdvbi9oZXhfbW11LmMgICAgICAg
ICAgICAgICAgICB8ICA2ICsrKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICAgICAgICAg
ICAgICAgfCAgMiArCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyAgICAgICAgICAgICAgICB8
IDE1ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY3MucHkgICAgICAgICAgIHwg
MTYgKysrKystLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi9tZXNvbi5idWlsZCAgICAgIHwg
IDEgKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfbWluaXZtLnB5ICAgfCA0OCArKysr
KysrKysrKysrKysrKysrKysrKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkgfCAgMyArKwogMTIgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfbWluaXZtLnB5CgotLSAKMi4zNC4xCgo=

