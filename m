Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F1BC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSD8-0008IR-ES; Thu, 16 Jul 2026 15:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD3-0008I6-RF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSD1-0000Ha-Q6
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:57:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJodGL3933387
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=UX9vURJ/4MF9kraWJfk9UFMgu5vtG9iNOzO
 hDB5dkoo=; b=PbAwETKgGruRxa4mBuCeDH9nrmEvx0EDws4OLQe87JcSRHvZzzY
 2uEP8N7sv9Ql2OcsNsRwnmsvOrS7Ir5fsQpHDMOtQuQh1usFMh0uZekIj0nOB6tB
 7fKQkCvWnb2rJIiboCKaTj9mh9Gg4UmqethNoCiNcafDa0dOMY90+LM5U3BMGCF9
 b9rPK42E0/co4VM/YsftZ2LNdD/kfqoAUgITCOB+usG2UB0obtI98/OHn6bKsUEN
 nxSW5qFxUfkhVpUDr8PJTeVDwVfe2VCQaG7tcNHr2VW1ZzkYs5lgvbNRj9MyBsX5
 CuLGI+Qj6aDzdGglXfnX5CvAPar87xUZLjg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf38ue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:57:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38de0739ab6so4942543a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231844; x=1784836644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UX9vURJ/4MF9kraWJfk9UFMgu5vtG9iNOzOhDB5dkoo=;
 b=Etvgbs/Ryl7RanZwXDr6CBy2NWhYF0jw7ye5FYLJOKs3GNyxA2g8QWR3ygs5Rf8K2H
 niD+CIlO6KodyYgzshR9nphunei7yYsGqB2nVgNL9lRRTy/CBxPfG7BvshP+MtWOvn+H
 rFgFO+cCpGEM+xljMGNbp0C2YelkLGcFpsge1WbUBBi9CJvkmVeaCGEI8oxv4ZFAw4XJ
 K9vZ/t250ggAPLKDAEmBI+B0ugDSe1aksRzjS3kgBkIxBH1nf3xUvRy4v8HzD791l3GY
 7a/elcoYYqjnXwFWqa1+edHPEWwu1RsZSIbGOuLSbHkU+bpKgQ/Io0+Ebj/OXGvz6wef
 3GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231844; x=1784836644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UX9vURJ/4MF9kraWJfk9UFMgu5vtG9iNOzOhDB5dkoo=;
 b=KJgQJxe0uuI0MYau08oVrvfwYsFC8ku+g8YxhcvqL6OwgrpiduMNufc6+oBnvdrYAP
 yr3wFVxGMngoO8wfnFi2vurgE3cDTNqEHb1MUvlM+wxF6sSXPTiUUT2ocu0A2v5XplDv
 yqzTZlzQHqt9ufg3TFa9ErdF10wMS5qnub0Ji6VUV4FPpjoVjFhaWGcL1j8FrRmD3EPd
 e98uMGBzMPnrTfcqL+x49FRA4MqvFZQsscCRjjetpIxqljmJtxH6BDYLTCzxK4p7tLaK
 sq+OePHkgO1K9ZescgdDrukXTWbKfLUcUAp+4Shy89ZjVuhGpIEA0cEeGCWd2g2Gw5ip
 H8kw==
X-Gm-Message-State: AOJu0YyzcfjB9PIRwlakXYxHDGGTeNwGycdPCNHIHUOdLr18FXXPCfNq
 n2CSuCV0KblVFCCDN67P6/NDpwCfL7OjD9Pee4mdamXi8cuRGpVL6mAbOga62Vq4dukHEnF2cce
 9bdb9Nb8IWnW+0UBCIQhdCCMOHzRNhMrIcVzNvjxyG54nSxdNUn7klR+3hPtNS+vBjw==
X-Gm-Gg: AfdE7cnSgSB4NKOlLOe0FgW1KgUdJZwfuKvKV3wZnLn7T9Uki9htcMMoifrmpT84e58
 OuSuye8AT9yoIP5MODZUQ+cglM56Od6Z2L4ANtueB3HtVAyG7hij31Mx4bANJUgIXo8IchEPVaB
 ovelbXX1vTSELT5BnyJtqawwOW1tN3AatmnjmbwdIUaIs+jNJH/SrfSWqamUBhRrS/y74+cCHYH
 hi5OAvoWmNLNqp+mXEGwbwFYjNZlAJacP9cLHPz5DYrIvnd84wRX5tjR6EIt+md2BnmYLl72Uax
 djg1fYQomeI24pjcu9Vi32xf7mrlTOFrcmsI5VgVsnoFh+muLtTHTDIY2i9BSpcIEFDr94IWd/C
 GkglnmP7kGlGpjBAjXuYi2NDqA4lrnsylwvVlKc0OYloPqpWNsD8TPtRc4VcFSC/1RllECsk=
X-Received: by 2002:a17:90b:5906:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-38e29ff97bdmr8865197a91.3.1784231844583; 
 Thu, 16 Jul 2026 12:57:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5906:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-38e29ff97bdmr8865171a91.3.1784231844034; 
 Thu, 16 Jul 2026 12:57:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6a5174sm14494672eec.15.2026.07.16.12.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:57:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/2] Plugins fixes for 2026-07-16
Date: Thu, 16 Jul 2026 12:57:13 -0700
Message-ID: <20260716195715.3218862-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KQ72wpBw0ZZX9oigvGUvPDMeFjo_wvPL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfXzm2G0tlKQjWX
 70079IIGiFQ8nIn/IRTm588BIfdUhHrnDCHPg18inPmZrsooqC0K2O8m843za2IwePU12+Cs8UO
 XvHEvw64oisAV4tnBFC2f4LxUHb+xaXWuozcDSBzC72QlKVbL3dR2JONYJhxZyeBdmJQU+uI2Yg
 X9r5vkNT0zsK65X6ZX0xq0BxWXAMQFfGNoTVtre1eDlpDn9UPd6rCvlNuDrnC0OSC1EuMsu+lm9
 xmRpaVS82zbp4h2BUJ8qxmwIv6zEZlXcfcnfEqQ4GtbvU8FMqEqhV++CCJ7MOxLbtT+M838dCU8
 PBiv2p8lB3HVOPCpllyyNicMssBEraBfwejJ8zmxh+dBt+NdTxWQ8ygrK+sSKipsRAGED+abL5/
 ENKLA/KKyG6QRw3MAe8TByXo1q0wQ5yfOjyOyMwe4VuVmOqAyJq+SuzhZ1MU1cYyoai5yqGgPFP
 G29IOD0eRn8vw3y8zFA==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a5937a5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=OZcmDFxvAAAA:8 a=MAKquEBSEbejAvWtep8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-GUID: KQ72wpBw0ZZX9oigvGUvPDMeFjo_wvPL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwMiBTYWx0ZWRfX3tQpgHy/5+nV
 qASbpPP5qhnOCrWjCR4a2BnQrM+rNK2Cs7vXczV8FHPaVVXBz845rWW5E+SUBvqnHhrA+ymnaDE
 miE59Qcc5JuqM3WhoNjJ9AD5+gHSNGE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160202
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

The following changes since commit eca2c16212ef9dcb0871de39bb9d1c2efebe76be:

  Update version for v11.1.0-rc0 release (2026-07-14 20:36:23 +0100)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/plugins-20260716

for you to fetch changes up to fdff1c864aaab3c2458c2d6802a5cfe9dfcbdff4:

  plugins/execlog: fix execlog vcpu_exit execution print loss (2026-07-16 10:33:59 -0700)

----------------------------------------------------------------
Changes:
- [PATCH v2 0/2] plugins/execlog: fix segfault and flush output on vcpu (Harry van Haaren <harry.vanhaaren@openchip.com>)
  Link: https://lore.kernel.org/qemu-devel/20260716094126.787556-1-harry.vanhaaren@openchip.com

----------------------------------------------------------------
Harry van Haaren (2):
      plugins/execlog: fix segfault/race-cond on per-vCPU structures
      plugins/execlog: fix execlog vcpu_exit execution print loss

 contrib/plugins/execlog.c | 88 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 45 deletions(-)

