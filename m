Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C2CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBh-0001kR-Ux; Fri, 19 Jun 2026 18:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBg-0001kH-Sm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBf-0001ZG-BF
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXchp1251161
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=; b=Ak2dELeZzh8etEQ4
 mBMMkTwaCuIt9/4n1b2bIafIrK2pIKta7kyVvv0rCO9JGU9XFaNLg1koOKxizyHG
 GbkKJjW+Ql/eWyuAM8qfSVQBqJ6RDm+1A4oE7yNTn98PV50TginAmDyYm4PmxFSC
 0AqSo6KWEakOwc6hq4gNHoCUe3swFgLltAgLXzq1VV+BxYL6wvTbyYp8CVAoAfAl
 5j3eIAk6MUEkORUZeEYcfg83E8+A4myLqfyGXO5Ura4J0dy3bXMyUeNF940+2DTc
 FHbsBo87qwMZKXPCWlL9SwWn1xFqeilhbiAH/s0S0inHFXa0dfiuk6EoxhevozSY
 zRfIAg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewbgp8n2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4413327eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909975; x=1782514775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=G0FUMbRlYfC3p0dXtxfiVyuE1ynLkVNgGmds1LjpACSLURf+L6XjvQAZwLAMTzALHB
 8NNiARWVL81IfO7Fjx3LMFvmSwsM7sKrjOkJmLfTAIoX+zEbuf4akCpm0jOvXgaE7Rct
 UEgYhxjlGawTzSh835C05+WiySQRy2cdK2hWUI5gPgW5Dfm+WJRGskdcNxNBQtd05Byk
 zycfr5kFJR4Iv0YfMOhJkTRnGJxjGDO3XE7uKUMUN2TS0NRlcYLisXrLjV5vGSOkNtni
 GVuVtcZg7ZbDoGC2JmNBftNfuGIxG6pl6uRdQ3N7mUE0j7pxlhkLqciME+bY27s88Cpe
 rXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909975; x=1782514775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3FB08ozXJ75KuaQ0Uu8ai6pxj0RZ56tBJAjvVwXnq20=;
 b=UPJtqqSCV03m+awpWnlDA+WEVUBJ3USwMxkTJPjSDDHz+sErcSKIW+ebyLuvRoCPbb
 UpIgMhZr0al1rMCmVnjeywAgh7vAUgkf3Qq0pJUuv680avUYImVvA49OqKbVKl0ltx6D
 smFPJETGHmiEXP6xELlheJ02qCxz7Q7cbVdsGl1q3MUURt01+hgQXrraQyPFWtAMVDx5
 TdxX8+8jUCOT+RXBtjF4THpMkXNb8PHEp8fcZ5omqLrp5wLqSg6/dnKatZSPvcqED/Y6
 1BkYHBuMSeJSMRQcjmshS5D9vq1kats+Jitxpm2+L7j/HU057a/GV2XprJQXzuNgt+QG
 TMhQ==
X-Gm-Message-State: AOJu0Yxa4TG8b918IB4HGwiUN3Ir2T8wAZV4uA0FPOKrGXP5Vo3j/0y6
 xRo3fYR8JGw/Igh8KKVI5lYHKD92jcj8qHyx6ND9Bq3J+5xt75IwJqBHLt5Xa4xbU7WsdhaMhfv
 RynL6FXycw7HYGJc9K2XAApKEwhPWUivJ2hPpp+KUb6WoNcLlDRszdl21ijYgFtfb5w==
X-Gm-Gg: AfdE7cmog8DFGJKB5+8eMVd4tG6Kct6jiPjUdzJ4NJmE9r36zJL2l+mygnrYxLUEz1E
 I2yuOTk09TeJdUJskMIgTeaAkTo3/4yya/yyAa5hUM++d6t1BDb7yTnV102715Heag+cttG76rl
 pm9xzkoQO6fn8KUx3YuyN5tSQY3zhhxKPEd0i+8SSI5drwd5GZqwY29IFhgnl9GcSjFrPmFmAZ9
 vxtWNMCD8/JalwvcUZKzjfyOoOPRU/NXkrdbI+GydcWJyZpY4bz/+wvXfPMobEs7Ckn77E+U82f
 fPpee+G2WEsQUwEDkscGqaE8qUpQtbdkkWLaQD5QSNhP2uaHXRIiBY8bS5PR/M5nNbVrKS4aBvL
 xxr2dPCBTVCqEDMUFAWU7Bs/66ZjABPo8NKVhTbg4reGPS3jxGziNCpymwwY=
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id
 5a478bee46e88-30c0d17fb0emr2348653eec.32.1781909975325; 
 Fri, 19 Jun 2026 15:59:35 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa7:b0:2fc:9d97:d59a with SMTP id
 5a478bee46e88-30c0d17fb0emr2348633eec.32.1781909974824; 
 Fri, 19 Jun 2026 15:59:34 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:33 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 13/74] target/hexagon: Add guest/sys reg writes to DisasContext
Date: Fri, 19 Jun 2026 15:58:10 -0700
Message-Id: <20260619225911.159473-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: fzQji_Z7qMsT-3rYqeULG3v6sU6eZH3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfXwUU2pnFOuVv4
 bel/4lLueFBqoyeMHZECFGB4Db8lTSdEBjyWxwAdWJkrAIY740SbD4XZ8UukVaulke4aYflVKdT
 DZP/GQu7enL8jwmsUswuS92MxQEhJam5VFkswuCYm3XqodlVCh/C3Xz2AljY9TQB1B8+JXe1dCD
 0faF5Ntg2Ky6jSI+DcvSIClfsx6m/5pMNHQA8kLsjZgEjgcTE/kMjxGIiMp0zE4HMbyPHdPaTRV
 Y4x1FccPuSUgmoR9zozLDthmEcYoMEhbDnGyBhMmyh9Ffd/yiO0v7zP1gV0k410OOfF4npfJpSN
 lesWenkOM5qf1STleGJZHz1Y+iAE6l4ePLJOnBHmKaMTtAuIqlniCI7TlcsbwgmDPYiw1p5DUNG
 tqM4iTufl1iFGf+uUG2uvt2GmRjWeGJTIDuYqcalgJeMT1S0OiwY8nNcNG9RAVKfn3JSBwyCkRN
 K1el7LWt/DCDf9Eo8gA==
X-Proofpoint-GUID: fzQji_Z7qMsT-3rYqeULG3v6sU6eZH3M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMCBTYWx0ZWRfX0C1TrS+rJ7Eb
 c4R7o4lPRN0fW4q4JvQaFbwxALhCEQBIaRkAbsRPCSGrdiI2P9MS8o0swH7CMK4q/OA2LkBa/ht
 k5okrKA3jH6GSr+pXzZqKtXMoGEEbvM=
X-Authority-Analysis: v=2.4 cv=d8vFDxjE c=1 sm=1 tr=0 ts=6a35c9d7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=tdgd3nfel_K54e3JQaMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190220
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZp
bGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmgKaW5kZXggZDhlZWE1NjE5
MWQuLjU3NzY3YWNmMDAyIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAor
KysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtNDEsNiArNDEsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKICAgICBERUNMQVJFX0JJVE1BUChyZWdzX3dyaXR0ZW4s
IFRPVEFMX1BFUl9USFJFQURfUkVHUyk7CiAgICAgREVDTEFSRV9CSVRNQVAocHJlZGljYXRlZF9y
ZWdzLCBUT1RBTF9QRVJfVEhSRUFEX1JFR1MpOwogICAgIGJvb2wgaW1wbGljaXRfdXNyX3dyaXRl
OworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgaW50IGdyZWdfbG9nW0dSRUdfV1JJVEVT
X01BWF07CisgICAgaW50IGdyZWdfbG9nX2lkeDsKKyAgICBpbnQgc3JlZ19sb2dbU1JFR19XUklU
RVNfTUFYXTsKKyAgICBpbnQgc3JlZ19sb2dfaWR4OworICAgIFRDR3ZfaTMyIHRfc3JlZ19uZXdf
dmFsdWVbTlVNX1NSRUdTXTsKKyAgICBUQ0d2X2kzMiBncmVnX25ld192YWx1ZVtOVU1fR1JFR1Nd
OworI2VuZGlmCiAgICAgaW50IHByZWdfbG9nW1BSRURfV1JJVEVTX01BWF07CiAgICAgaW50IHBy
ZWdfbG9nX2lkeDsKICAgICBERUNMQVJFX0JJVE1BUChwcmVnc193cml0dGVuLCBOVU1fUFJFR1Mp
OwpAQCAtODEsNiArODksMzQgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0IHsKIAogYm9v
bCBpc19nYXRoZXJfc3RvcmVfaW5zbihEaXNhc0NvbnRleHQgKmN0eCk7CiAKKyNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQorc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNh
c0NvbnRleHQgKmN0eCwgaW50IHJudW0pCit7CisgICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdf
RzMpOworICAgIGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICBj
dHgtPmdyZWdfbG9nX2lkeCsrOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQgY3R4X2xvZ19ncmVn
X3dyaXRlX3BhaXIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBybnVtKQoreworICAgIGFzc2VydCgh
KHJudW0gJSAyKSk7CisgICAgY3R4X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSk7CisgICAgY3R4
X2xvZ19ncmVnX3dyaXRlKGN0eCwgcm51bSArIDEpOworfQorCitzdGF0aWMgaW5saW5lIHZvaWQg
Y3R4X2xvZ19zcmVnX3dyaXRlKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBj
dHgtPnNyZWdfbG9nW2N0eC0+c3JlZ19sb2dfaWR4XSA9IHJudW07CisgICAgY3R4LT5zcmVnX2xv
Z19pZHgrKzsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfc3JlZ193cml0ZV9wYWly
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgcm51bSkKK3sKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUo
Y3R4LCBybnVtKTsKKyAgICBjdHhfbG9nX3NyZWdfd3JpdGUoY3R4LCBybnVtICsgMSk7Cit9Cisj
ZW5kaWYKKwogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfcHJlZF93cml0ZShEaXNhc0NvbnRl
eHQgKmN0eCwgaW50IHBudW0pCiB7CiAgICAgaWYgKCF0ZXN0X2JpdChwbnVtLCBjdHgtPnByZWdz
X3dyaXR0ZW4pKSB7Ci0tIAoyLjM0LjEKCg==

