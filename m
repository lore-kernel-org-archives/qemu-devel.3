Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF82FC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk4nC-0002kb-1D; Wed, 15 Jul 2026 14:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4nA-0002k2-He
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wk4n8-0005yV-LY
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 14:57:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBX3x051127
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A1dKhWmVEpScQ2nw0jysc1Wm3J7x83ChWxRAi/X43Y0=; b=D9A2/0VS0Jo8pQuX
 wXzcA19r94WKf/ZEjtCMGM+wtMyHQXnAKB7rtGBawoUHImI481OvrakuAPvpohsM
 1K0af8rxi2Y9k1/onlfyCjRDQ1RER1r7U+yFCS+nTDwMMMCcKHFvxM/Ido3LBHmt
 Xym5ggDeejSvxDcv15/NEjrTJdcJrZc1L00uUP41XV2VHukucl6nwDf2wzTg4N9b
 VhN3QGlFBkqOlOzkFWr4Veo9Umsgq2mBOb39mdx6y5RfA5Xc6zlpjNrx3cYFqyQm
 0Ladhd3jouQfRA2xrGbGQMuZkGXUT43aQz46Vp7cu9yfGImcnwMz2aZCfwETt4cv
 pK3T/w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecny8yfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 18:57:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38d7fcd1f66so8516520a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784141829; x=1784746629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A1dKhWmVEpScQ2nw0jysc1Wm3J7x83ChWxRAi/X43Y0=;
 b=cqbMMDDwVlBDqVH8TULdyraK5TjPAMnLjK4lhNga84UOvX48yA892Jro2MqqqKztoG
 te71lDFzDk/zUaz++kN+EmFRDCxtvaEg/NKXlBKm90rVTcpoER2tlCTvBGJOdJ8E+kv4
 OmA2hxZHsDbFf6FAklV/oJ06d/uEINdESH+f7nIGQq0NbOwRTDXywkETtdbYKmEm46hN
 wWoQmoFTjgTcaREz+Zc4Jyt9JdKAWPvyelsLz/CSGkwWVPHIiqKuUnlIdPUyZpj1v6hA
 cbUuc3JKc1VPGu8uj8WM49833eXu0FwuCWUzN0RNyXnNtZgoPQeXq8ZEttEqtYzRLnko
 0B5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784141829; x=1784746629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A1dKhWmVEpScQ2nw0jysc1Wm3J7x83ChWxRAi/X43Y0=;
 b=X8TPE+mgmelnINfDR/5juJ8vlDnEqVRyLPVltJP3UkGr+kJFoTVt6Jfks6TAOifa65
 7bYqNPqiXjnuGzb/MTURxK9pmXJPc+gGuHeLBriNwWu0epOX3+BhfvA6yGV0Dl8gPrLc
 oHunfVE9HcMuIK4+Ikz/np9srsZFzkZoF5SrXeRmOoqgsJu3QpZ101NqBA8tFnBk2EiS
 2T7ZZ1mmT7v8ylESj1dcWA6HyjOmtV8/6+Szz0qZ19OuxoAOe1wlkGpcZd71cNo7BcL1
 9CvpVolhfanmxWfVwaHXGPkJ9mOWU9LP+TT9VnGf2ylBztTR53CKhhdmAGHWB8DHAM9L
 uqmw==
X-Gm-Message-State: AOJu0YzLpMJMqFv9erDxG9WmoGrl1Z47zDwmby0LGrn+BmPPOKYdMfvE
 g20zdk8NISS5cj4Zmh7+qJTj5TNLAVO+Yv5/osxlIRH4x9srM9uQWDEwOY4pXYeDJCjJqjW5M++
 IIdCIKOm2d381r9sUeENkooePx8CisWfXQKpwrlsLXx98DArHs3aMpWb1+05CMcXR2A==
X-Gm-Gg: AfdE7cmyNkAg3EdGoaoNInrh9KDwBDvDfXdm+EtdVO3fDLT+oZbZysE88TREoJdPVSW
 bFHNrn2h47WQNRcr8OP9BySSaCnJuTLJwRAcpC4dwr/BCvx6dJmqysGHqf9+PdrHbmmvRtBLuSa
 1lqdV6TYiJMK6srd9AqpCeRBdUpZ9tIc9Yv0EqGOwgsNwjRXBMqpqR2lXzM54sDlxbubFXTbAML
 ooLTfaWGH1QNsF/HUhRexBhAeZDmoOLnRvcpg+XCmYW/O2raHIRrPsn9fBknscIvQSLlDOS+3vn
 r2MueTySD6EP7qh4kkRiB/UK6u0wFMZuyo4rS+ayMSM/jxUWa+QMQNDIyV1dB4zCWxUzRwTTTvJ
 R+zveh2OE/A57Nu5RV7ze4l4rdX1WaIH8maRclE3xbPeN097eIdaAvFw5mQA=
X-Received: by 2002:a17:90b:3b8b:b0:380:a568:cc4e with SMTP id
 98e67ed59e1d1-38e1add8e69mr6794556a91.9.1784141828558; 
 Wed, 15 Jul 2026 11:57:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8b:b0:380:a568:cc4e with SMTP id
 98e67ed59e1d1-38e1add8e69mr6794518a91.9.1784141827877; 
 Wed, 15 Jul 2026 11:57:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm5469546eec.25.2026.07.15.11.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 11:57:07 -0700 (PDT)
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
Subject: [PATCH v2 3/7] bitops.h: Add find_first_bit32()
Date: Wed, 15 Jul 2026 11:56:57 -0700
Message-Id: <20260715185701.1287176-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
References: <20260715185701.1287176-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX3USrGKvYaPx9
 MByP1pP2fdO/xUTTM4X/smYeNH3NyNRHD+BQnx92jMnhhkiPLNMOwrvcci5lb3abD7su/rDv/XB
 AbZSOVm6iCzYFrTpDnSVJh5MHmGSVU8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE4OCBTYWx0ZWRfX1aqg2Z/66Enl
 uKQQaufRZdceXeEsuNYPphEaz3XjGojQg98BEBGDYZ541rlnSIy9sFLtfgBHlNbcbREJsRXA5o4
 7LVtG9BIZqVTmP66HOMBY7E69F7LGQnc2iX/O1GpBqk5tnWsJ8MdlcC4b7Wzq6FI4JeRj/yME34
 5E3NIPL18lz6tBW6EBccy26PflbFKqUsNLqFwPFjVnOQRsSB9zpJcqz9L6syfszFKBsMJkY/LiC
 9dmynmocZOF7YouGXLhGlFvEw7VnBq2V3B2t1PxJGEyrVMjtb6KLqoN9hAF2MeRnKJ0kHLC90v2
 qajgRIWs05/ZVPvaxWySlkB6aJ2nIv2oYPbauvEaTvVmKv9Zsy3C32dJVjupfEOHgWzEGjsZhML
 ng4HFcGScRsv8NfrgKI5b+sMdT8qn6yGJujG4jX6OYgykuAQoyA55kQMJoE+ckKeYn8cPN69jZu
 rqwuoeAfJrKjZPgI1Xg==
X-Proofpoint-ORIG-GUID: PfLVYwE6NlGyCqc0cLNT_5fezwoO11pt
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a57d805 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=w2bVgGKsJa40EddZz84A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: PfLVYwE6NlGyCqc0cLNT_5fezwoO11pt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150188
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

c2V0X2JpdDMyKCkvdGVzdF9iaXQzMigpL2V0YyBhbHJlYWR5IGxldCBkZXZpY2VzIG9wZXJhdGUg
b24KZ3Vlc3QtdmlzaWJsZSB1aW50MzJfdCByZWdpc3RlciBhcnJheXMgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlCmhvc3QncyAndW5zaWduZWQgbG9uZycgc2l6ZS4gZmluZF9maXJzdF9iaXQoKSBo
YXMgbm8gc3VjaAplcXVpdmFsZW50LCB3aGljaCBwdXNoZXMgY2FsbGVycyB0b3dhcmRzIGNhc3Rp
bmcgYSB1aW50MzJfdCBhcnJheQp0byAndW5zaWduZWQgbG9uZyAqJy4KCkFkZCBmaW5kX2ZpcnN0
X2JpdDMyKCksIGltcGxlbWVudGVkIHRoZSBzYW1lIHdheSBhcyBmaW5kX2ZpcnN0X2JpdCgpLgoK
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIGluY2x1ZGUvcWVtdS9iaXRvcHMuaCB8IDMwICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2JpdG9wcy5oIGIvaW5jbHVkZS9xZW11
L2JpdG9wcy5oCmluZGV4IGM3YjgzOGE2MjgzLi5mNzM2M2E1NDc5ZiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9xZW11L2JpdG9wcy5oCisrKyBiL2luY2x1ZGUvcWVtdS9iaXRvcHMuaApAQCAtNDMsMTAg
KzQzLDkgQEAKICAqIGJlIHNvbWUgZ3Vlc3QtdmlzaWJsZSByZWdpc3RlciB2aWV3IG9mIHRoZSBi
aXQgYXJyYXkuCiAgKgogICogV2UgZG8gbm90IGN1cnJlbnRseSBpbXBsZW1lbnQgdWludDMyX3Qg
dmVyc2lvbnMgb2YgZmluZF9sYXN0X2JpdCgpLAotICogZmluZF9uZXh0X2JpdCgpLCBmaW5kX25l
eHRfemVyb19iaXQoKSwgZmluZF9maXJzdF9iaXQoKSBvcgotICogZmluZF9maXJzdF96ZXJvX2Jp
dCgpLCBiZWNhdXNlIHdlIGhhdmVuJ3QgeWV0IG5lZWRlZCB0aGVtLiBJZiB5b3UKLSAqIG5lZWQg
dGhlbSB5b3Ugc2hvdWxkIGltcGxlbWVudCB0aGVtIHNpbWlsYXJseSB0byB0aGUgJ3Vuc2lnbmVk
IGxvbmcnCi0gKiB2ZXJzaW9ucy4KKyAqIGZpbmRfbmV4dF9iaXQoKSwgZmluZF9uZXh0X3plcm9f
Yml0KCkgb3IgZmluZF9maXJzdF96ZXJvX2JpdCgpLAorICogYmVjYXVzZSB3ZSBoYXZlbid0IHll
dCBuZWVkZWQgdGhlbS4gSWYgeW91IG5lZWQgdGhlbSB5b3Ugc2hvdWxkCisgKiBpbXBsZW1lbnQg
dGhlbSBzaW1pbGFybHkgdG8gdGhlICd1bnNpZ25lZCBsb25nJyB2ZXJzaW9ucy4KICAqCiAgKiBZ
b3UgY2FuIGRlY2xhcmUgYSBiaXRtYXAgdG8gYmUgdXNlZCB3aXRoIHRoZXNlIGZ1bmN0aW9ucyB2
aWEgdGhlCiAgKiBERUNMQVJFX0JJVE1BUCBhbmQgREVDTEFSRV9CSVRNQVAzMiBtYWNyb3MgaW4g
Yml0bWFwLmguCkBAIC0zODIsNiArMzgxLDI5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYml0
MzIobG9uZyBuciwgY29uc3QgdWludDMyX3QgKmFkZHIpCiAgICAgcmV0dXJuIDFVICYgKGFkZHJb
QklUMzJfV09SRChucildID4+IChuciAmIDMxKSk7CiB9CiAKKy8qKgorICogZmluZF9maXJzdF9i
aXQzMiAtIGZpbmQgdGhlIGZpcnN0IHNldCBiaXQgaW4gYSBtZW1vcnkgcmVnaW9uCisgKiBAYWRk
cjogVGhlIGFkZHJlc3MgdG8gc3RhcnQgdGhlIHNlYXJjaCBhdAorICogQHNpemU6IFRoZSBtYXhp
bXVtIHNpemUgdG8gc2VhcmNoCisgKgorICogUmV0dXJucyB0aGUgYml0IG51bWJlciBvZiB0aGUg
Zmlyc3Qgc2V0IGJpdCwKKyAqIG9yIEBzaXplIGlmIHRoZXJlIGlzIG5vIHNldCBiaXQgaW4gdGhl
IGJpdG1hcC4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmaW5kX2ZpcnN0X2JpdDMyKGNv
bnN0IHVpbnQzMl90ICphZGRyLCB1aW50MzJfdCBzaXplKQoreworICAgIHVpbnQzMl90IHJlc3Vs
dDsKKworICAgIGZvciAocmVzdWx0ID0gMDsgcmVzdWx0IDwgc2l6ZTsgcmVzdWx0ICs9IDMyKSB7
CisgICAgICAgIHVpbnQzMl90IHRtcCA9ICphZGRyKys7CisgICAgICAgIGlmICh0bXApIHsKKyAg
ICAgICAgICAgIHJlc3VsdCArPSBjdHozMih0bXApOworICAgICAgICAgICAgcmV0dXJuIHJlc3Vs
dCA8IHNpemUgPyByZXN1bHQgOiBzaXplOworICAgICAgICB9CisgICAgfQorICAgIC8qIE5vdCBm
b3VuZCAqLworICAgIHJldHVybiBzaXplOworfQorCiAvKioKICAqIERPQzogTWlzY2VsbGFuZW91
cyBiaXQgb3BlcmF0aW9ucyBvbiBzaW5nbGUgdmFsdWVzCiAgKgotLSAKMi4zNC4xCgo=

