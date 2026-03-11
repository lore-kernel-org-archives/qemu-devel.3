Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55D1FD88F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ary-0000mD-OX; Wed, 11 Mar 2026 00:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arn-0000kc-1C
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arj-0008Rz-6G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B06hoR1266016
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :message-id:mime-version:subject:to; s=qcppdkim1; bh=ZP1Fn0Sc1+c
 ZMv5ikTyGoWH/SfV6wPvMgRk4OHBTHww=; b=LQm5QhzOsOJuOg+4rJlnHwUgpC+
 6H9p3j8ZHuhZ7Yj/mNKxB3rPJzjliOS9QLeBF0/mJoC2I10WlFdqgFdjnfWWfBt8
 CWEHW9x9ii3//nDC77jNlpGHfcjAJo5yVEwem4KmS/nGmPyIAfPr8XJztdyUFfkG
 UQzjk07rwAhSmRVLcPmq+/1EDA2rUCFYjWg+x9J2XAPnCo61Co6nT4r+jMa+Pnnj
 BGzBHjbaYjJvUPpx0ikciki9vDdO0CZ99BglMiwoAp20DmeQ9cwCWbBfOYJYmlpJ
 F9pHfCI8NAb87gOEJBli1hc1N0YcsJ8AX952yPRPOJ53VUamYmujBwOKb2w==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctpkfj7va-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:06 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4176f39cea6so6734283fac.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202086; x=1773806886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZP1Fn0Sc1+cZMv5ikTyGoWH/SfV6wPvMgRk4OHBTHww=;
 b=Amij0jWt58Bi8Hk1wxN34J4YcZnN3igO0wOLfv/Sk37QS4L7YAqxQADJI5rTq4ZoAy
 2C4NSugXBr3dB0Rihh/UL5HTt8EeN74mS/rxOsndW9vHIq73Qa3P1svfDnSMsEe75NO4
 eB2MNLil3haDdem5ktMZrH7qgToOLFR2KKwsSWho7yHHxgwnEET0rrigdeK8mcQRbUwK
 b1oQC3ncKZ8dapshU5zbYdAJtBNlY/e7j59rxWm+IcInvUHbxIHGGldT+bkchYaIgzEz
 5Mi7iueLJIGfQBAbsoWTB66qzNsHirEU7p30m3sQ/YBq38+woqn5YWO9JlaDIXYjsKmi
 5sPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202086; x=1773806886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZP1Fn0Sc1+cZMv5ikTyGoWH/SfV6wPvMgRk4OHBTHww=;
 b=pobcaQV60EXjMdutz4JD4195Q1raxvsTYAozLbHpwG6jNBtLwAUxHwpVVzsUXaRb1X
 vISOq6q3oGg/ao3X0XlRonrqkQDo2s2KDNb7re/4qTELoT4ogUGgqTo7byJYgr0Fk2ag
 gegT0c1a+IFiuDXaUB2rbsT1VBwknbhJCB2D+Kw1/FX3m6IrNF3oSKKDgpkG7+wFJQ3J
 bPYwTsMhTIHw1y7AO6U0X5hv0Jb1csqV6np1YzhwlaN0otM7zh49VtHxXQlO9iUm+GMG
 pCzHG1mvdOaGrT6IY/MBaR3qknD5ARwKw6yn5B5AbYz5ask1Wl/jGI/tPB8ZGFaFiXU6
 12cQ==
X-Gm-Message-State: AOJu0YxQ0mG829mwz5bGDzKC8R9PvxgblU7gKegmJODQoSJAd7qmhwqf
 L6Lk2AuieyrmOxPvbvLVqgK2p5ne0Bj4LBmATHcOl/kgrzwANAbo1vCag5q2bbpj+ytIO0M2nAv
 mcRbBgjepKMGeoQSrPlPXo+QqBtcVe7d93fsUEpFwh6rost4+zgD6y+5t3XoaRIvfYg==
X-Gm-Gg: ATEYQzznE+2zPxr/Rxu9+uiDmydxJma4WMyZxsrOjbasHE057QIudRTb3WvkCid5rAb
 lhGV4We8+P3+T0GrtwYK1Iqie07x+rbtFJRUCU4epFiK0VJP7n7QwcTfiQtD8mStCnmJZHrsFE3
 G1QWSMLgtU2Hj1QS+xuRM6+62Ln+skmwAYcKd5mslAcfFVrIeuumPfisVrGOHQbkaB1KAzhKYmS
 kYnnRhoFsjLcXUG9gZSJjq796ofauUttCnbRe/FZ6xSfRq47Q2LLwjEJe2Fx8KoZS/ESJ/g6lrR
 2idBficp0/I8q4DatEmHehopTBMnsuq0vrtjR+oCQmuypIvs6sjVO4fJVG2kXNo91j7mjhjKh58
 bI8/86809IkNFxDW5Pvv97IUPnEgtKh5+MRllY/MSP3BBv2U0XC2o7CclK4lhoHHy4n1C7w==
X-Received: by 2002:a05:6870:798d:b0:409:9a0b:b733 with SMTP id
 586e51a60fabf-4177c5d49d7mr947917fac.10.1773202085966; 
 Tue, 10 Mar 2026 21:08:05 -0700 (PDT)
X-Received: by 2002:a05:6870:798d:b0:409:9a0b:b733 with SMTP id
 586e51a60fabf-4177c5d49d7mr947887fac.10.1773202085494; 
 Tue, 10 Mar 2026 21:08:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH v3 00/32] Hexagon system emulation - Part 2/3
Date: Tue, 10 Mar 2026 21:07:26 -0700
Message-Id: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: LCEUrI61ObcvLMOmSEF9ZviELEyrPuGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX6qBV+BviTHSB
 Wf7MQiG96RCdilj6DFjNQwuBsU2M/G0aFdO/8inTE773q86F4Z0e1gY+t1W3E0N0FPb41nPxpi7
 ZwW4t0REvUS212t+9ZxEp/0ooaiPx/gWwtDqoOoxYJp8ZoukzxQb08vcd9Ya4waxKq+uowAzqcl
 JQ1eJy6mnMOwgrAeId5lA9w8Fd0B3gZF4Iez7RobuD9Xu4hQ6gPE4rLfWArUBa9P/zrp2DAWoKF
 Jojpqh+v8D/IFzIE5RvdbNpAOf7VtjF9pDsDnfl4MjVIzvLUW1PZua09Bn5wxSxBPPUsNMym1l9
 d2p0VAcvnj0F7b8Ix1S9CSkVrjw5/TuvmDw/z6Q0eCoGdvdLF80daYVd67HOc6RACkKtm9/eNrn
 AanRt/dEAvbepw+c+Yj0ZhPubm0WssqdaPY1h+Dkd2e3cAihIQawoA4uNg6ibmMQMB9sdwTCzpg
 PqG+PJORHATG/nt228Q==
X-Proofpoint-ORIG-GUID: LCEUrI61ObcvLMOmSEF9ZviELEyrPuGd
X-Authority-Analysis: v=2.4 cv=Gq5PO01C c=1 sm=1 tr=0 ts=69b0eaa6 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p_mR8qS5J_EkG-FELWwA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhpcyBpcyBQYXJ0IDIgb2YgdGhlIGhleGFnb24gc3lzdGVtIGVtdWxhdGlvbiAoc3lzZW11KSBw
YXRjaCBzZXJpZXMsCmJ1aWxkaW5nIG9uIHRoZSBpbmZyYXN0cnVjdHVyZSBmcm9tIFBhcnQgMSB0
byBpbXBsZW1lbnQgdGhlIHJ1bnRpbWUKaGVscGVycyBhbmQgQ1BVIG9wZXJhdGlvbnMgbmVlZGVk
IGZvciBmdWxsLXN5c3RlbSBlbXVsYXRpb24uCgpUaGlzIHBhcnQgYWRkczoKICAtIEhlbHBlciBp
bXBsZW1lbnRhdGlvbnMgZm9yIHN5c3RlbSBpbnN0cnVjdGlvbnM6IHN3aSwgY3N3aSwKICAgIGlh
c3NpZ24sIHN0YXJ0L3N0b3AsIHdhaXQvcmVzdW1lLCBzZXRwcmlvLCByZXNjaGVkCiAgLSBTU1Ig
KFN5c3RlbSBTdGF0dXMgUmVnaXN0ZXIpIG1vZGlmaWNhdGlvbiBhbmQgZXhlIG1vZGUgc3VwcG9y
dAogIC0gQ3ljbGUgY291bnRlciBpbXBsZW1lbnRhdGlvbgogIC0gVExCIG9wZXJhdGlvbnM6IHRs
Yl9maWxsLCB0bGJfZW50cnlfZ2V0X3Blcm0KICAtIEludGVycnVwdCBoYW5kbGluZzogZXhlY19p
bnRlcnJ1cHQsIHNldF9pcnEsIHNvZnR3YXJlIGludGVycnVwdAogIC0gU3RhY2sgb3ZlcmZsb3cg
ZXhjZXB0aW9uIChmRlJBTUVDSEVDSyAvIEZSQU1FTElNSVQgY2hlY2spCiAgLSBDUFUgZXhlY3V0
aW9uIHN1cHBvcnQ6IGNwdV9leGVjX3Jlc2V0LCBwb2ludGVyX3dyYXAsIHN5c2VtdV9vcHMKICAt
IFRyYW5zbGF0aW9uIHN1cHBvcnQ6IHBrdF9lbmRzX3RiLCBpbXBsaWNpdCBzeXNyZWcgd3JpdGVz
LCBuZXh0X1BDCiAgLSBTeXN0ZW0vZ3Vlc3QgcmVnaXN0ZXIgbmFtZSBkZWZpbml0aW9ucwogIC0g
VENHIG92ZXJyaWRlcyBmb3IgdHJhbnNmZXIgYW5kIGxvYWRfcGh5cyBpbnN0cnVjdGlvbnMKICAt
IEd1ZXN0IHJlZ2lzdGVyIGFuZCBwY3ljbGUgcmVhZGluZyBmdW5jdGlvbmFsaXR5CgpDaGFuZ2Vz
IHNpbmNlIHYyOgogIC0gRHJvcHBlZCAiSW1wbGVtZW50IGNpYWQgaGVscGVyIiAobDJ2aWMgZGVm
ZXJyZWQgdG8gYSBmdXR1cmUgc2VyaWVzKQogIC0gRHJvcHBlZCAiSW1wbGVtZW50IGFyY2hfZ2V0
X3N5c3RlbV9yZWcoKSIgYW5kICJJbXBsZW1lbnQKICAgIGFyY2hfe3MsZ31ldF97dGhyZWFkLHN5
c3RlbX1fcmVnKCkiIC0tIHRoZSBhcmNoXypfc3lzdGVtX3JlZwogICAgYWJzdHJhY3Rpb24gbGF5
ZXIgaXMgbm8gbG9uZ2VyIGludHJvZHVjZWQgKGNhbGxlcnMgdXNlCiAgICBnbG9iYWxyZWdfcmVh
ZC93cml0ZSBkaXJlY3RseSkKICAtIERyb3BwZWQgIkltcGxlbWVudCBtb2RpZnlfc3lzY2ZnKCki
LCAiSW1wbGVtZW50CiAgICBoZXhfdGxiX2xvb2t1cF9ieV9hc2lkKCkiLCAiSW1wbGVtZW50IGhl
eGFnb25fZmluZF9sYXN0X2lycSgpIiwKICAgICJJbml0aWFsaXplIHN5cy9ndWVzdCByZWcgVENH
dnMiCiAgLSBEcm9wcGVkICJBZGQgZXhlYy1zdGFydC1hZGRyIHByb3AiIChmb2xkZWQgaW50byBQ
YXJ0IDMgY29tbWl0KQogIC0gUmVuYW1lZCAiRGVmaW5lIGdlbl9wcmVjaXNlX2V4Y2VwdGlvbigp
IiB0byAiQWRkIFBDIHRvCiAgICByYWlzZV9leGNlcHRpb24sIHVzZSBmVFJBUCgpIGhlbHBlciIK
ICAtIEFkZGVkICJJbXBsZW1lbnQgc3RhY2sgb3ZlcmZsb3cgZXhjZXB0aW9uIiBjb21taXQKICAt
IE1vdmVkIFRMQiBsb2NrIG1hY3JvcyAoZlNFVF9UTEJfTE9DSywgZkNMRUFSX1RMQl9MT0NLKSB0
byBQYXJ0IDE7CiAgICAiQWRkIFRMQiwgazAge3VuLH1sb2NrIiBub3cgb25seSBhZGRzIEswIGxv
Y2sgbWFjcm9zCiAgLSBSZW1vdmVkIENPTkZJR19VU0VSX09OTFkgZ3VhcmRzIGZyb20gY3B1X2hl
bHBlci5jIChmaWxlIGluCiAgICBoZXhhZ29uX3NvZnRtbXVfc3MpCgpQcmV2aW91cyB2ZXJzaW9u
czoKICB2MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDkwMjAzNDg0
Ny4xOTQ4MDEwLTEtYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwogIHYxOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwMzAxMDUyODQ1LjEwMTIwNjktMS1icmlhbi5j
YWluQG9zcy5xdWFsY29tbS5jb20vCgpCcmlhbiBDYWluICgzMCk6CiAgdGFyZ2V0L2hleGFnb246
IEltcGxlbWVudCB7Yyx9c3dpIGhlbHBlcnMKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGlh
c3NpZ257cix3fSBoZWxwZXJzCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBzdGFydC9zdG9w
IGhlbHBlcnMsIHNvZnQgcmVzZXQKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IG1vZGlmeSBT
U1IKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IHtnLHN9ZXRpbWFzayBoZWxwZXJzCiAgdGFy
Z2V0L2hleGFnb246IEltcGxlbWVudCB3YWl0IGhlbHBlcgogIHRhcmdldC9oZXhhZ29uOiBJbXBs
ZW1lbnQgZ2V0X2V4ZV9tb2RlKCkKICB0YXJnZXQvaGV4YWdvbjogQWRkIHJlcHJlc2VudGF0aW9u
IHRvIGNvdW50IGN5Y2xlcwogIHRhcmdldC9oZXhhZ29uOiBBZGQgaW1wbGVtZW50YXRpb24gb2Yg
Y3ljbGUgY291bnRlcnMKICB0YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGhleF90bGJfZW50cnlf
Z2V0X3Blcm0oKQogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgc29mdHdhcmUgaW50ZXJydXB0
CiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBzdGFjayBvdmVyZmxvdyBleGNlcHRpb24KICB0
YXJnZXQvaGV4YWdvbjogSW1wbGVtZW50IGV4ZWNfaW50ZXJydXB0LCBzZXRfaXJxCiAgdGFyZ2V0
L2hleGFnb246IEltcGxlbWVudCBoZXhhZ29uX3RsYl9maWxsKCkKICB0YXJnZXQvaGV4YWdvbjog
SW1wbGVtZW50IHNpYWQgaW5zdAogIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgaGV4YWdvbl9y
ZXN1bWVfdGhyZWFkcygpCiAgdGFyZ2V0L2hleGFnb246IEltcGxlbWVudCBzZXRwcmlvLCByZXNj
aGVkCiAgdGFyZ2V0L2hleGFnb246IEFkZCBzeXNlbXVfb3BzLCBjcHVfZ2V0X3BoeXNfcGFnZV9k
ZWJ1ZygpCiAgdGFyZ2V0L2hleGFnb246IGV4dGVuZCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoKSBm
b3Igc3lzZW11CiAgdGFyZ2V0L2hleGFnb246IERlY29kZSB0cmFwMSwgcnRlIGFzIENPRgogIHRh
cmdldC9oZXhhZ29uOiBJbXBsZW1lbnQgbW9kaWZ5X3NzciwgcmVzY2hlZCwgcGVuZGluZ19pbnRl
cnJ1cHQKICB0YXJnZXQvaGV4YWdvbjogQWRkIHBrdF9lbmRzX3RiIHRvIHRyYW5zbGF0aW9uCiAg
dGFyZ2V0L2hleGFnb246IEFkZCBuZXh0X1BDLCB7cyxnfXJlZyB3cml0ZXMKICB0YXJnZXQvaGV4
YWdvbjogQWRkIGltcGxpY2l0IHN5c3JlZyB3cml0ZXMKICB0YXJnZXQvaGV4YWdvbjogRGVmaW5l
IHN5c3RlbSwgZ3Vlc3QgcmVnIG5hbWVzCiAgdGFyZ2V0L2hleGFnb246IEFkZCBUTEIsIGswIHt1
bix9bG9jawogIHRhcmdldC9oZXhhZ29uOiBBZGQgUEMgdG8gcmFpc2VfZXhjZXB0aW9uLCB1c2Ug
ZlRSQVAoKSBoZWxwZXIKICB0YXJnZXQvaGV4YWdvbjogQWRkIFRDRyBvdmVycmlkZXMgZm9yIHRy
YW5zZmVyIGluc3RzCiAgdGFyZ2V0L2hleGFnb246IEFkZCBzdXBwb3J0IGZvciBsb2Fkd19waHlz
CiAgdGFyZ2V0L2hleGFnb246IEFkZCBwY3ljbGUgc2V0dGluZyBmdW5jdGlvbmFsaXR5CgpNYXRo
ZXVzIFRhdmFyZXMgQmVybmFyZGlubyAoMik6CiAgdGFyZ2V0L2hleGFnb246IGFkZCBzaW1wbGUg
Y3B1X2V4ZWNfcmVzZXQgYW5kIHBvaW50ZXJfd3JhcAogIHRhcmdldC9oZXhhZ29uOiBBZGQgZ3Vl
c3QgcmVnIHJlYWRpbmcgZnVuY3Rpb25hbGl0eQoKIHRhcmdldC9oZXhhZ29uL2NwdS5oICAgICAg
ICAgICAgICAgICAgfCAgMjAgKy0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCAgICAgICAg
ICAgfCAgIDUgKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oICAgICAgICAgICAgICB8ICAgNyAt
CiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oICAgICAgICAgIHwgIDI1ICsrCiB0YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaCAgICAgICAgICAgICAgIHwgICA2ICstCiB0YXJnZXQvaGV4YWdvbi9o
ZXhzd2kuaCAgICAgICAgICAgICAgIHwgIDE3ICsKIHRhcmdldC9oZXhhZ29uL2ludGVybmFsLmgg
ICAgICAgICAgICAgfCAgIDQgKwogdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggICAgICAgICAgICAg
ICB8ICAgMyAtCiB0YXJnZXQvaGV4YWdvbi9zeXNfbWFjcm9zLmggICAgICAgICAgIHwgICA3ICsK
IHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oICAgICAgICAgICAgfCAgIDUgKwogdGFyZ2V0L2hl
eGFnb24vcmVnX2ZpZWxkc19kZWYuaC5pbmMgICB8ICAxMSArCiBsaW51eC11c2VyL2hleGFnb24v
Y3B1X2xvb3AuYyAgICAgICAgIHwgICA3ICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICAg
ICAgICAgICAgfCAzNjggKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHVf
aGVscGVyLmMgICAgICAgICAgIHwgMjgyICsrKysrKysrKysrKysrKy0KIHRhcmdldC9oZXhhZ29u
L2RlY29kZS5jICAgICAgICAgICAgICAgfCAgMTQgKwogdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMg
ICAgICAgICAgICAgICB8ICAxOCArLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgICAgICAgICAg
ICAgICB8IDI2MCArKysrKysrKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jICAg
ICAgICAgICAgfCA0NDMgKysrKysrKysrKysrKysrKysrKysrKysrLS0KIHRhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5jICAgICAgICAgICAgfCAyNDggKysrKysrKysrKysrKy0KIHRhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkgICAgICAgICAgfCAgIDMgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0
ZWQvZW5jb2RlX3BwLmRlZiB8ICAgMSArCiB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9sZHN0Lmlk
ZWYgICAgIHwgICAzICsKIDIyIGZpbGVzIGNoYW5nZWQsIDE2OTYgaW5zZXJ0aW9ucygrKSwgNjEg
ZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vaGV4c3dpLmgK
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYwoKLS0gCjIuMzQuMQoK

