Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4593FCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn8r-0003Id-Sk; Mon, 22 Jun 2026 18:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8q-0003I7-Sn
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn8n-0006F3-I8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJcT5r1938648
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=TQ7wacG7PRMUh4jD
 LYuUT+jtECb9X+Bp9I/onLBt3cDfM4ETJC2E3LbOsabUoE5DNKYrpQXj1BGrMaLb
 Asot/LuJfN6UyFhoafCKAW0GVv7/pF8CkrU23BL/Yg8cHWhW7UcQTOShxjKTPNiA
 1B+i8A7ydOW6q0t4BJYkCXw9rAJzBspOtJKNMHNlFgU0DhVzI+DQOlBbnt1yRdjR
 N+fVWonq3bVRfDGuN9pxF9x2yKweAuRRkN53UFVrd4feUZShUxtKxTfnOVt4sliH
 nyJqCw0PwO6NWgrcys+t2BMBpDRLLBnYBYV2ffgKSKWkpiqg/Q5/E/Rnr8pePOZA
 5YnA5A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye9wsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so11725264eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167356; x=1782772156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=jJUHHlg3ytoUkewJOnn3U1X96KnkxL6vnehTNb5Ij0p5JHWei0+8f/jp7fjWx/O/Yd
 rtivz1UT556GezaBT7SGxvbwzS24VZYrzcghL3EQkky4igDKJuOsUieFssfORNKclJKk
 /92OhCp7yfHYSc7Ep58C68O4u/sp6EI291H0luSXLUfSEE8C1SgdHC3jGrfOtzszvc7E
 rNeowblMxSSQggmASyXR7NwcJ5JFh7Np/59/fYBCCv8/j25UahZQuYIYp1sdFqxWcy45
 GE66rOtLYVPlUKv8uliCX1Kuuhrp06w2bMEEa4ftmjzTg2O9Q4zsaMdZJBwr8++2Wt03
 Fi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167356; x=1782772156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=sU9RwYAtmevJIZkzMHbVALTOLIgqkbpGYKeNTgjMRC6+W2qUVaxW0d1X4TPDdYAkZ8
 VjVJwzofQC4pEMoFQY2IMnmS2f0BxURaJVlH4e45Z7lXAL2F6Twcj2mQ5Wl8J7Iw8AWw
 S4qWyUY3L4xuVS/8yUDZT7QxWijLckDYQG3WaO2ZprwHKDFl7SCVcw1DAZf1N/fmGgvW
 lmUy5F+0GL+2JnXdRRmugmxE5t6CXJKC1yv0vmiB2IqX2LuS5hkeJYaXcy8VHuLBkFiq
 fgpJw7IyXvGIg0VNNw8pZYYGCosPvnPj8tyBV5me7/bTxxpQboTu+4vaC7RxD4YsjO3q
 q4CA==
X-Gm-Message-State: AOJu0YwUD/VjPOp0nyxn+/j3BQSVL0bdI0Gk/PLq1c3BWU5fsKgu9HBO
 bA0zkBsWPiVBFcCcJOB9r16XgzlfTZNVtiE4saM6ZTTSPC8YfVycF6OawR5Kk8u79Yv6hDynbkK
 /m1A4a2LzwC/eF88Oi8DQ6ye55rdnOpFcpWBfBbYxu9mBKlBcGhGXWgZFGPuywgQfVg==
X-Gm-Gg: AfdE7ckIKTVNVlDqaaBDrfKsvymivC1YFHLIMdnRyFxL73CXdScKDvJMntASfEYM3GK
 QexIs+JA3EOi9oY2ncuGEG/iyaREBEwG45n3wOlO3VDzZnFBXEzN5CnqtCgct9dXk/hyzY9K2TS
 gCgMO2DZnoOWs0KKREkc/pc/T2fbZBW5OeaDe0FSL+fgjR780BJdlQSJt1aPXpNSkC8YD4Mt1II
 amuU17JL8rj9gzYw41Qv3pBbNdk1TJf/0Q9cpFHootLpJfBH91W28dqokbdQRgTEB4xinmt0Zak
 nJWXsQHB2wWIK9FpfPooIkYL8n11kegZIqTh6Ovlnn33P0izPTiBSqsk4fx07GkBb046D/y+CCy
 fnu96oKB4eSeuT+WjjwcmdNaIzN55A2aX8UHaPzA1UBJMca+QJ06Ffe7G5fo=
X-Received: by 2002:a05:7300:80c4:b0:30b:eca2:be75 with SMTP id
 5a478bee46e88-30c06e2b026mr12948204eec.8.1782167355598; 
 Mon, 22 Jun 2026 15:29:15 -0700 (PDT)
X-Received: by 2002:a05:7300:80c4:b0:30b:eca2:be75 with SMTP id
 5a478bee46e88-30c06e2b026mr12948182eec.8.1782167355103; 
 Mon, 22 Jun 2026 15:29:15 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 03/75] docs/system: Add hexagon CPU emulation
Date: Mon, 22 Jun 2026 15:27:52 -0700
Message-Id: <20260622222904.607771-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: EYnFGx6Sa6_Ieu0_pcTKD5xqGg7uPd86
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX6fSCfDptf18S
 AkmhPPtRAyT9rYYa/vFfHuqsQmmeS0DYbrMboEnxqPpBJeLg0MNKWefDBM7G5a1XmQpnTkDaIsr
 EYowFyTPkBncod7XqoDaq9TFT71Vzes=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX7VTFrN+H4sKg
 KWbD2L9/pqHP3Yc5gmBskiz+FUl1dbfaW36GDzpbF1UOFAi9jiABW9RCbZPZWOcUTfCBRQHg3N5
 dG3C1ivE/qCyV//ICY6pZTnRVNc/auTueS/n5cW9DrsL1Yds6PNYH3nKRuE99ArMnwmccjKBVqq
 zDDvTYF3pd6M4n9hm2nQ0clQZgQs7jS1HjHlzz7m3OiaWAn0ZUIxPuW+8eu/AWOLYybnqILPNBw
 AD5U3bO5ixjj8WZvCOq7eGL30SgS7hBj3GooIlBIBUGAiLMmIHanzDphiC5jadix1ijkg1tz4rm
 uySst1zzWNQrit0rCr1VeSoFQplHgHQiJuAVPb6QwSOeEsmxzvxVgsXZZaAEwd11g2RRWsZ4kOe
 Qwt2lYY6Q2N0gWUOn7EiEtCB4LXvgi2ojJdmjRh9583iS5XRx49GeGS2OLorxh7qOHypwzg28p8
 zfYVIS2l5IJFjAn0bow==
X-Proofpoint-GUID: EYnFGx6Sa6_Ieu0_pcTKD5xqGg7uPd86
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39b73c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cgpk
aWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIvZG9jcy9zeXN0
ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi4zNmY1NGYwNThhZgotLS0gL2Rldi9udWxsCisrKyBiL2RvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdApAQCAtMCwwICsxLDE1IEBACisuLiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCisuLiBfSGV4YWdvbiBFbXVsYXRpb246CisKK0hleGFn
b24gQ1BVIGFyY2hpdGVjdHVyZSBzdXBwb3J0Cis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQorCitRRU1VJ3MgVENHIGVtdWxhdGlvbiBpbmNsdWRlcyBzdXBwb3J0IGZvciB2NjUsIHY2
NiwgdjY3LCB2NjgsIHY2OSwgdjcxLCB2NzMuCitJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUg
Zm9sbG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgorCistIEhWWCAoSGV4YWdvbiBWZWN0
b3IgZVh0ZW5zaW9ucykKKworRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhl
IEhWWCBleHRlbnNpb24sIHBsZWFzZSByZWZlcgordG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3
MyBIVlggUHJvZ3JhbW1lcidzIFJlZmVyZW5jZSBNYW51YWwKKzxodHRwczovL2RvY3MucXVhbGNv
bW0uY29tL2J1bmRsZS9wdWJsaWNyZXNvdXJjZS84MC1OMjA0MC01My5wZGY+YF8uCmRpZmYgLS1n
aXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQt
aGV4YWdvbi5yc3QKaW5kZXggNWY3MDg0YTZhMDguLjQxNmI4ZjdiZTc2IDEwMDY0NAotLS0gYS9k
b2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CkBAIC05OCw1ICs5OCw2IEBAIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gUUVN
VSBoZXhhZ29uLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09PT09PQogLi4gdG9jdHJl
ZTo6CisgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

