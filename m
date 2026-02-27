Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D77FEFB51
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 20:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw4Zq-0006nK-Ro; Fri, 27 Feb 2026 15:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zn-0006ls-Vy
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vw4Zm-0006nm-K4
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 15:36:43 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIm7pU1713233
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fwKGE8PtYgXXAM4TboOYlPrze7hGIXNlT1jwkhANj+4=; b=QaGxnoTobRFii9J2
 9evkPBsS54TihS1clLvM+n1uZIir8M0kMWf6LACYGj7eCAAKKl7Z4C5IhelxkvW1
 +ORmBpwM3leVxMPIQExSkUDeJWd8zPVOof0aQJvawYLJ48IhbNR9cQ+D0Tyq2ncj
 QDdgvP9UQbqVA98b5w5oYJb80/mNy0iUn9p+TJSL9fweaOarbOktQFyV6KDJ8NX5
 86RURSasqr8bp2ON5r99fN3wOHpfv3WEmGwk6YkdVROi8C+6YAClnzPWB+tHqwRG
 HXdVxk3L14cVTJl/+iKbXIBTftxz2f4j5iOOw/et/D3XEE1sRmdgdME9AgELjHd6
 kgpLgg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgv5gacm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 20:36:40 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-464a2e39173so24779244b6e.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 12:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772224600; x=1772829400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwKGE8PtYgXXAM4TboOYlPrze7hGIXNlT1jwkhANj+4=;
 b=FjYdf3ctl2fJjsQB5NdQgkvF8ra7VRtwetgDSyJFUM/1OD/2b4pKsQ7PLgnOKvwbz8
 E6aGbqv+XtTO6nDAmXlgTNrK9bl/VVA5jv83HlfXs1MS3OV9T5ZHaBwdZ5NyuL1Fj5PP
 5vrvW/xoXoY2FamW25yvYEBvEpF+NWfDeEy8T6eU+y63s1VWXK/AY4M1eGUr0UjR/It9
 MUk85BEpwMSBdlxvpB+POSbdIrzlSj/CENyONwLVZGySdRg9Ay/vtR9xoqm+TVq/UIgZ
 Ydd1nX+2lqTWOysKuHQpNOrcM2LYfE2l4V2mWCc9RWBuAOSU7DADvlh4BvYIFnH0p/wX
 MT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772224600; x=1772829400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fwKGE8PtYgXXAM4TboOYlPrze7hGIXNlT1jwkhANj+4=;
 b=rM94yHeAt43Nj4eyz77LRT3P13YcNgTdlFTB7ugujtyh6ZfgBIN5ygrEqgdJaYWuHQ
 cxn2pdldTccs408z82rMRfiHUE0rjowUin3zXYwBArikxMfEPLqgNOknGu0TBQuTXHGF
 E6oKn2cxTnEqBl8k0zeTjPGTy8cxci6OgBgwhfjwjp5S4w1DgMSc35N7mo/MUkjA50Mu
 atnY25WCT9wt8sCaO9krMGdptQk0MfITbGe/kGOGEE6ImxGmOg/jLgIYoPQsK/W3r6LR
 shRd+B5m6U3Q60hVvNaSrx6Z0MdjcufZoctngMj2xXnehGclVJDEGx/Wv9WK0y/aBaEt
 NCBA==
X-Gm-Message-State: AOJu0Yzu1pgJR6BCsAu+a/Oly8QM4oAcFuBqrOLSMBdRvrvzicNlNbQo
 aM4LW99iChPrt6ArO/PHrfWSel4PJtq07cPmdqeZVFOLd+tV+iRkMJp+R1EkLHzSI54SFboU8xi
 o6XD1I/qxZCbcpoPvCcJB8WthjYhN1VHsbwlk8w24Q1CttuCUon1aMUvcFowNW2XPtQ==
X-Gm-Gg: ATEYQzxRGo96ZUQ8ibty91Y/IsTwK/3gRqjybV34ZgaOLEIeu+FaOx6WBhM+KDu1aMG
 Qo+/GZj15Ki0TN33g7PIgmkYBh4jRI3e1X+GgjaFdu/lVwGqrdaWZ7RigJzIZEHBq0wodbPzKrx
 mQeGXXGoy98+cnp3M8lw9eIRYYUm9cEA1EHxqGDMuJn+YHSwnqwRdC41wEevAl1UI00JtST5v8d
 dD+Tvcmacwtt8FZNjjzo/pOopkFo0f2yE3TRHXeC99JtE96fcfYTRRonZzIxo7fYOgbDlyOf4H9
 AhnOE6Ps15jeQJiV4XaotYMCl/sr1bp0b9m/Xh6/jzo7NAiYFm+nr4PFY/K/iRLdDrEBHjbnrfg
 /EQdNt7OjAfZsJph/DiJHcrfCdrgRs4TQBRRsAzbCWKWrKqs/4rsTwddJyU8UjQN576cfoA==
X-Received: by 2002:a05:6871:a193:b0:416:402c:822a with SMTP id
 586e51a60fabf-416402ce97amr476458fac.25.1772224599958; 
 Fri, 27 Feb 2026 12:36:39 -0800 (PST)
X-Received: by 2002:a05:6871:a193:b0:416:402c:822a with SMTP id
 586e51a60fabf-416402ce97amr476439fac.25.1772224599522; 
 Fri, 27 Feb 2026 12:36:39 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cbd405fsm5762935fac.0.2026.02.27.12.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 12:36:39 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 04/37] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Fri, 27 Feb 2026 12:35:54 -0800
Message-Id: <20260227203627.932864-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RPq+3oi+ c=1 sm=1 tr=0 ts=69a20058 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=UrstOHIbV4iY_BwJnwMA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NmbH6-28N0R1ZTu89uXo5TfTEVvMu64-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE4MSBTYWx0ZWRfXwRw6Ah1WEt4w
 zPOolRQeN5Lq+vFTCMSJOq0kk0eh8xgT31agtPlnhs8Xw4DkDQqy92omUe+tR3RBCXuJYc4BnS7
 V4kjxkCvDF0icnUS4Z6KHcPcSweMyBJh9DHDh/zPyUiyNzfv1/b2DwwCOQ6ix8dkp0AWmPt5L1X
 MND+0COFY8VHpC/HZp2MIZE/OOnvMvuxDMH4RfUAyHEx2vQmPkEXxLBwzAUATFMgHlpdJA3/X1q
 5/hw1TISAoCdSIH42lWkpM7akQe6+z3GCksbRWz3cQ1yuUyZbHxq1LtzVtF/w31lSxELLjBm7BO
 maktxSbbc81+kIBjDrZJkpH4fRdWqZOSogfIKcxW36E901Rq9Ae/AQILIm1MTnDtoOkx6BCrsCk
 mguFJbDSm7b0ImT1EFzD3efjPTAliCprV3eOBADbVR4rGTKhPs6RbMtyC3wZTpgTxpy5UI0Wl99
 x/0yIQNXR1IWhGLbffQ==
X-Proofpoint-GUID: NmbH6-28N0R1ZTu89uXo5TfTEVvMu64-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
aGV4X2NvbW1vbi5weSB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggYzBlOWYyNmFlYmUuLjYzZjgz
YThkZTJhIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw3ICsyNDcsMTEgQEAgZGVmIG5lZWRf
bmV4dF9QQyh0YWcpOgogCiAKIGRlZiBuZWVkX3BrdF9oYXNfbXVsdGlfY29mKHRhZyk6Ci0gICAg
cmV0dXJuICJBX0NPRiIgaW4gYXR0cmliZGljdFt0YWddCisgICAgaWYgIkFfSlVNUCIgaW4gYXR0
cmliZGljdFt0YWddIG9yICJBX0NBTEwiIGluIGF0dHJpYmRpY3RbdGFnXToKKyAgICAgICAgaWYg
dGFnID09ICJKNF9oaW50anVtcHIiOgorICAgICAgICAgICAgcmV0dXJuIEZhbHNlCisgICAgICAg
IHJldHVybiBUcnVlCisgICAgcmV0dXJuIEZhbHNlCiAKIAogZGVmIG5lZWRfcGt0X25lZWRfY29t
bWl0KHRhZyk6Ci0tIAoyLjM0LjEKCg==

