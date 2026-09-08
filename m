Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F46CC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 19:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x41cv-0002hj-2p; Tue, 08 Sep 2026 15:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x41cu-0002hG-0D
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:37:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x41cr-0005Fw-Qc
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 15:37:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688IILAJ403287
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 19:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SJ6+4Xm6Y3gN/Mz/SqqHQu
 tSNYLw7hZgPOHa0soR6Yo=; b=HPS1xRcb7+kj5F+BO7bB59WCrY2a3vBUEqlxWJ
 8PmoVfsV8jMd7GDG1TQb6crPsWbvFK4eRR+muWofh/HgpLr+/65AAO7QsNh4Xs3+
 4ntAc/O5Vy2Z1GxD/znwDxvf7LMV82GlTppYPM38swnyTKq4ZriQ9DmBKm5PIXo8
 lGyCAFY9uisR4pKkXsDaxesaG/T2lNlCxZa/ZInaqtr0A6uigtmJsG36t4Nvtmom
 Apb+TTNaMUEROWpULik84Raz9fdgNqmHf49Iw0zBfQoNmFDh3Hd8POqceAaww5Vi
 4NJiWLXlWWjy+E63CWptKV1/FkAmyXjm6EOq8jkYpEmDvLqw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqha0ds9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 19:36:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1a439db36so4910524a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788896218; x=1789501018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SJ6+4Xm6Y3gN/Mz/SqqHQutSNYLw7hZgPOHa0soR6Yo=;
 b=TpJIVnOcX6u1WjLdD/xMp/30VIZash3MzBVP2ATs0RhS10VJtfHzEG7Ynzh9e+RitF
 lYc1OE7v4i3TxHBCg/WujA062xOyHGOT0QBbxu4olIbxN+0PC3KIeZgrpuMagT5G+GF4
 dd9KGhuwF9r5mGKZhANYc2OZwsFEEI03PFiiSn1Q3mMML4ilAifSnjfCqFHSZpTUsyEQ
 Ref6LYA16lEBxs6jA1yhJgKD+MqPJwI6ey4SqGs701BNPrPEtSiEq0XvZr3gY7Hckwk9
 EPfN2A9bJRAtynVeAx+1TfMSh+xm1f5xEVcfPxUU0yGLZwvbtoxzGSTiDLdaZPKXBE9s
 zuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788896218; x=1789501018;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SJ6+4Xm6Y3gN/Mz/SqqHQutSNYLw7hZgPOHa0soR6Yo=;
 b=Gh81khmf6zY7o+t73LokZZ2DQ02za7nGWYWxpN1Jp5A7tACuHDsBw9zxNqmCTt384B
 eaGYLtDlSUziAdSY3MDmButpH8T37fXKS9DgAw8hZ+IfmjRhTCdk/SRfYEKEHm+foA5Z
 sgEd9oJ24sL0REHSfyp6wPT1sdyzYS+k6z0sD56z4JrEwXMKHIecH5ubS9zfkvSsm9UO
 Q7EIxdyM53CllphCMNcpwSAs0rS7YTdiTldsc3Y8lGLkFusv3hxYZVg+/8AyIs9UnYTi
 bC3Kg8pURhOcku/31ZhROSXbadK1UkRJ6LGkDHJr0+DsffsqVMOwMIxPvhXofHkCSEIN
 fP6A==
X-Gm-Message-State: AFuF++lBgglpTFoFQdl/FMlS1JL0miFU/wTWeh5DU5NScrPanfay8RmW
 ZHX57BHuSR+RVgcPdMocLymRLA/N4tovrVGnALiB+W/eD+4emnCTX9oKdF5yMpvsi8FdIH+3Q8H
 Zvut7hky3SQs6tj1dzR4HmGKFW7NakKXrTlspRARtssKrbF7FJMhgiigwqdYDJtv2Tw==
X-Gm-Gg: AYBFou3ka82F3rSyPJ8r+wli+dTIX97h1gM5Ph4Dpmsm7nYF32pc9Lk71utMU/Mn7Kv
 DsNhxQvx4YVtditTenUBgkVz/QERrK+JyXFKdIJXyDycEfgtO6NF7sugToGoM1YqceLGLxtpEXT
 GbvMG64wLKBxi3rqrCG6PEATxtCO1qmakOmp9tRDQDGZuUiqQggy9oQLUAnFMajnL9+LLk+oJLF
 8kRFaawYNW0/uvSMGfDaN9VdLRJ3sU2WlLWFzN/vIVbORdKnnKOZVo3TqFmURJ5Kvs+Yj0Jn4kH
 O8bMQ1Jhjuyk/UHoBlwWfezuG6nkTealaanZMAlvsVGEacJI3jSNBpLMr+098SmkkZig5cPXhyZ
 S9sTf3uxWWSNxyn+ZJ7+3aE1/O8YXnHfVzhoCT1vTzHG0zSQE
X-Received: by 2002:a05:6a20:12c8:b0:3da:bea4:621e with SMTP id
 adf61e73a8af0-3dabea46dadmr109658637.26.1788896218403; 
 Tue, 08 Sep 2026 12:36:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c8:b0:3da:bea4:621e with SMTP id
 adf61e73a8af0-3dabea46dadmr109610637.26.1788896217837; 
 Tue, 08 Sep 2026 12:36:57 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3397d6d1becsm173868eec.22.2026.09.08.12.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 12:36:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH] tests: install pylint for functional linters
Date: Tue,  8 Sep 2026 12:36:56 -0700
Message-Id: <20260908193656.2787108-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIxNCBTYWx0ZWRfX4BN+uXb99+Nd
 Q9JTFJlj1EwBGRt1BrBYuMOizoRtUG5mSkC15q9+QD8NK7EJ4DbZXIrrBm9ZsH1Ae5f13jb6wbJ
 816CeMgODEdHLhk6dBoANTLhNahdljrBG8TM92Gy6Ja55lUJtkAEpNK8lJHAc4mR/urNnY959a+
 oW3toKrQIKcQAjQ2E37yBDplstc45jNWOjGrndt5ue4kSFuFO98F6cCrqGMPaD1xwmiD8kCJTkM
 AzF8gBPFTtivGG1x3Sf65mNEDLCVLIMx6kXnqgaFvIXxnkjcH7jI5+lriOL0To7FqtE4RO2Q0tA
 x5SzXHe3cF/3XnccKI0hZ+ThT21WBJk8ETgiPcOR9ZeI9qYRudsVMOStw9lxp8FRl0ry6nWdG+Y
 6qxXh4MwM12DjalVdgOP8/bI01Alpd3hiyNrsA8TYPN7BiJ1Gi69LiTaRKO0CorEXo1SzADLI61
 j4kXeaF7C4cbVw4ZkRQ==
X-Authority-Analysis: v=2.4 cv=Z5Xc2nRA c=1 sm=1 tr=0 ts=6aa063db cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=jJHGEvBZ9D_KORtLzZAA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: fh2t7iN8mpVfXCWgtghaXF3iRkp_MdxB
X-Proofpoint-ORIG-GUID: fh2t7iN8mpVfXCWgtghaXF3iRkp_MdxB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIxNCBTYWx0ZWRfXxBHxiIlXt1J+
 8vwQdXpKXWuz0I5GwWZJ4HCpCv9/oCrbuKB0uEd4F3nhP2bT8Suo1LNBLGmHAZmGHivssgVUgYb
 tgJUDs6hLaXlGOmr+DgJDkMgHpLGyVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080214
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhlIGZ1bmN0aW9uYWwgbGludGVyIHRlc3Qgb3RoZXJ3aXNlIGltcG9ydHMgdGhlIHN5c3RlbSBw
eWxpbnQgMi4xMi4yLgpPbiBteSBzeXN0ZW0gdy9QeXRob24gMy4xMiwgaXRzIHdyYXB0IGRlcGVu
ZGVuY3kgd291bGQgZmFpbCB3aXRoOgoKICAgIEltcG9ydEVycm9yOiBjYW5ub3QgaW1wb3J0IG5h
bWUgJ2Zvcm1hdGFyZ3NwZWMnIGZyb20gJ2luc3BlY3QnCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogcHl0aG9uZGVwcy50b21sIHwg
MSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9weXRob25k
ZXBzLnRvbWwgYi9weXRob25kZXBzLnRvbWwKaW5kZXggZTRjMTBkNGE5ZjcuLjY1OGQwYWFjMzY4
IDEwMDY0NAotLS0gYS9weXRob25kZXBzLnRvbWwKKysrIGIvcHl0aG9uZGVwcy50b21sCkBAIC00
OCwzICs0OCw0IEBAIHNwaGlueF9ydGRfdGhlbWUgPSB7IGFjY2VwdGVkID0gIj49MS4yLjIiLCBp
bnN0YWxsZWQgPSAiMS4yLjIiIH0KICMgZmV0Y2hlZCBmcm9tIFB5UEkuCiBbZnVuY3Rlc3RzXQog
cHlnZGJtaSA9IHsgYWNjZXB0ZWQgPSAiPj0wLjExLjAuMCIsIGluc3RhbGxlZCA9ICIwLjExLjAu
MCIgfQorcHlsaW50ID0geyBhY2NlcHRlZCA9ICI+PTMuMC4wIiwgaW5zdGFsbGVkID0gIjMuMC4w
IiB9Ci0tIAoyLjM0LjEKCg==

