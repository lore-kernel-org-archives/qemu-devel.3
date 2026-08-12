Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8925FC5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2U2-0007HS-CX; Wed, 12 Aug 2026 02:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2U0-0007Gs-8V
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wu2Tx-0003q6-Jj
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:30:35 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62Z2E1720792
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=; b=Ex7axO2h9mzJSuP+
 lelujIp4evcMfERv2zPeM6Jmzj5l3KCVUHHUzdzyhboY8EJ2shVuXcSr9Mk0EPAe
 85xOUPgxAhWCDZkEKmLw2X9U28p4j9UaekZuEUA9SG5PNlUBqsm0gTqRASF1O/lE
 Tl9FQqy+D5GS5RsgPdTZPF+dNjHAcvKWa9IAwclqNTSROLvdpXGXF18R/m98bXns
 udHyHb0dWH6xTrDXsIjg+5UvTwsqIaXBWei7rZfdFRhjixPrNYEhQHxPl2wAFSLO
 hpxeC/jMS5aJCLeZu8mSJGzocBw6WOcFtiCNGaF31YyEhfTkS9SLrPf4/sXmIxkU
 eP75kw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw0fbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:30:32 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso1151887a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786516231; x=1787121031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=;
 b=C/sU3IzXmKQ8mPiriBj2ONM0qDhagsNbu2GyfdBBxRBmTtNlSWZtVgKaexu2HUjomf
 UPjuRd4z9UMbfUiPZUtkAfdukTZBQsmQRUc1MSsc9gvOt2cDCLyu/pDv3buUSlqG7Rtb
 iJruYt7J5aIL/IP0XoB4CMcuMpzTagITcBRmBBijsCd4flV8hAaVl4XmZQy+zYxc2t10
 4njB5GdPWQYbFE4Gvp54bbn1stG4DN3bMA/y3yEJGVBk//2dARlIMTCftDHgCkB0myaB
 h9kyfv8XEtrUBfyI3jjtFvUrSB+H2ZAGjr/Ui3nISw9XtI7qE62KWNZ45gy29KR41tvE
 oYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786516231; x=1787121031;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4fDABiMFaO/xaHfzA5OtIuHLV6GRct9DHYuK8AefmJ0=;
 b=Sskot5lBxsXMoxYO/uzEWL7JwhkzatqlpUNps/aWjL5rTObMaif2hLgkNIPfMOh9O4
 mfe+8xjWNWlFg2rgPZvqjB42iRj8M/w2l073I+yoBVvO7usVO8v3CHXq/VvYqVezF56z
 YCqL90gVVm8Uw+6OR0buY928NOgn2KeZQi1R2InT5myoMuT4YlUeGnJXG6VHl1E/4Q7g
 aF13jJFSK6oK6Oyh8Z42A8Ept8yhByqmDxt/fZ7hY0I1tCxiJRkbIxQhWMZOYNLQsD8L
 gU6rad1Anth6z7cIC90jc7rP3+OiBntwtkocz3KIiPSNd5+qH/RSCePBRGwNX6rRvVum
 WMQA==
X-Gm-Message-State: AOJu0YwcnyvqjdJn77To7PIFjE+4hVwYHyKRWsWYjmYhhCWE8Z9C0gpW
 AAjeqiGbbEzsGX1ORXDeiKOig7Apt/Hk/+Zakbywh5DKtZmJmz+JHFQNqKOiN7aRHKntvEqXYqW
 Az4fBB1qounslifc3KCLeHKqimzSaaLKEB+pxzdmEJYX0fIkd3n5wbwzybw95wOW6rw==
X-Gm-Gg: AR+sD10zd4zisxfSzonlQtArFHGS/xtov9v1p08OhEoJ2BUbgCQp0w2vX3bANJzu6d5
 WXKa29hNSM/CVmFoLFNX6bH7jUixOafRy+Zh6AU936J3eFkpYS4i3YA6DSiDdH0h+ZAj41REO6K
 N1KLATi6syf/pbC8TTvcTGgqQAWJGk3Z0Tr3WDLcT0005ACBZZe8wN2w9Mqslr0QPg3oP85cB4M
 3khFT6CPcEXLMnyusjWjer91Rwz6hjgE8RpWC3wYSMFAUdhnEpl7Eag5utTdKrBCwq4Y+7tvGeG
 R5kk+Vf2RZHBX7+fplh3bhELu41AHCXYj+a7yvcvKUG4hZZbkTpdZEzklrlk8KL5U6zs6D/o7SY
 SyvNnsYi4uQi7cnuPSmuyso5CoiTTmvDoSKEBG65oyaELOSP8
X-Received: by 2002:a17:90b:590f:b0:38e:542:6485 with SMTP id
 98e67ed59e1d1-393012c79a5mr3022274a91.12.1786516231454; 
 Tue, 11 Aug 2026 23:30:31 -0700 (PDT)
X-Received: by 2002:a17:90b:590f:b0:38e:542:6485 with SMTP id
 98e67ed59e1d1-393012c79a5mr3022205a91.12.1786516230935; 
 Tue, 11 Aug 2026 23:30:30 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f985e9fcsm771402a91.1.2026.08.11.23.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 23:30:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 18/41] tests/functional/hexagon: enable more arch_tests cases
Date: Tue, 11 Aug 2026 23:29:09 -0700
Message-Id: <20260812062932.543840-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
References: <20260812062932.543840-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfXxAedo125YzdZ
 OUC0XYRP+4gfvPMULcrXwimB4mqrptyX9g0Q5T5pSQSUAxDP7ux6qJiGVUJi/dSyfwSdiPu3aMx
 eatRdAEV4rbfcaRTqnVonKUww/8eygU=
X-Proofpoint-GUID: kkTPjgExmcJDtJKoR5sjM16a4Fax55jj
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c1308 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EF0Bc5xDYwCSNCb3zeEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: kkTPjgExmcJDtJKoR5sjM16a4Fax55jj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0OSBTYWx0ZWRfX+1+3vrJ8+Wwp
 BpuTnD07xbzIs4GM841d15mz7mA6JrJPIyFpEH19Kn8P1SpleDbguvOf/JPOzL94UMLH8iqYdtj
 OzsumodUpqvgNC9hSMsJhQsSWppD6/Xbpm1kamfGuFUo0YXQOHfSqO9XYMe0KYF66PjkjhaqdwV
 9Pj0pB80qgZHAZM+68iX8EH7aHaOHiV98MROwsWwLb+NtrKNoIMj/OMuPC9FFVq9tA+xrQnEEGr
 npWgL2o2Vbd518wLp9nbNVMRK+lMPVWycja61yGWYIrCd+jGDPqF8bmytRq/1pI4Rz+YoVQ92TG
 mEA6hDaWiJ3diEH2cRCqSMZysXvsFh+Ujo03f/t73zX1H2uvp6DSvoKjz9/PcPKa1ifaN3Uy3eE
 AIEmRKAMBgAxKEZi8XS5h5MAkk1/oa4GC0hrWKycJcp31b8y6otTo1EcZe8PA+x0A5A6sk7piul
 eSL7OYXsaLZFa/utscw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120049
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

QWRkIG1vcmUgdGVzdHMgZnJvbSBoZXhhZ29uLWFyY2gtdGVzdHMsIGVuYWJsZWQgYnkgUVRpbWVy
IGRldmljZS4KClRoZXNlIGV4ZXJjaXNlIGNhY2hlIG1haW50ZW5hbmNlIG9wcywgbDJ2aWMsIHRo
cmVhZCBzdGFydC9zdG9wLCB0bGIvbW11Cm9wZXJhdGlvbnMsIGFuZCB1c2VyLW1vZGUgdHJhbnNp
dGlvbnMuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBv
c3MucXVhbGNvbW0uY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVs
LzIwMjYwODA2MDQyNzIzLjM3ODUzNjktMTktYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMzIgKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgYi90ZXN0
cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5CmluZGV4IDJiYjM0ZjliOGRj
Li4wODM0Mzk4YzNiMSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rf
YXJjaF90ZXN0cy5weQorKysgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5CkBAIC01OCw2ICs1OCwzOCBAQCBkZWYgdGVzdF9pbnRfc3RlZXJpbmcoc2VsZikgLT4g
Tm9uZToKICAgICAgICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9pbnRf
c3RlZXJpbmciKQogCisgICAgZGVmIHRlc3RfY2FjaGUoc2VsZikgLT4gTm9uZToKKyAgICAgICAg
IiIiVGVzdHMgY2FjaGUgb3BlcmF0aW9uczogZGNraWxsL2lja2lsbCwgbDJraWxsLCBkY3plcm9h
LAorICAgICAgICBkY2NsZWFuaW52YSwgY2FjaGUgZGlzYWJsZS9lbmFibGUsIGJhcnJpZXJzLCBh
bmQgZGNpbnZhL2RjY2xlYW5hLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90
ZXN0KCJ0ZXN0X2NhY2hlIikKKworICAgIGRlZiB0ZXN0X2wydmljKHNlbGYpIC0+IE5vbmU6Cisg
ICAgICAgICIiIlRlc3RzIHRoZSBMMlZJQyBpbnRlcnJ1cHQgY29udHJvbGxlcjogZW5hYmxlIHJl
YWRiYWNrLAorICAgICAgICBpbnRlcnJ1cHQgdHlwZSByZWFkYmFjaywgVklEIGNhcHR1cmUsIGFu
ZCB0aGUgZmFzdCBpbnRlcmZhY2UuCisgICAgICAgICIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0
X3Rlc3QoInRlc3RfbDJ2aWMiKQorCisgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25l
OgorICAgICAgICAiIiJUZXN0cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3Rv
cCwgTU9ERUNUTCBzdGF0ZSwKKyAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5
LCB3YWl0L3Jlc3VtZSwgU1RJRCBwcmlvcml0eSwgYW5kCisgICAgICAgIFNDSEVEQ0ZHL0JFU1RX
QUlUIHJlYWRiYWNrLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0
ZXN0X3RocmVhZHMiKQorCisgICAgZGVmIHRlc3RfdGxiX21tdShzZWxmKSAtPiBOb25lOgorICAg
ICAgICAiIiJUZXN0cyBUTEIvTU1VIG9wZXJhdGlvbnM6IHdyaXRlL3JlYWQvcHJvYmUvaW52YWxp
ZGF0ZSwKKyAgICAgICAgZ2xvYmFsIGVudHJpZXMsIG11bHRpcGxlIGVudHJpZXMsIG92ZXJ3cml0
ZSwgQVNJRCBtYXRjaGluZywKKyAgICAgICAgYW5kIHBlcm1pc3Npb24gY2hlY2tzLgorICAgICAg
ICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3RsYl9tbXUiKQorCisgICAg
ZGVmIHRlc3RfdXNlcl9tb2RlKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIHVzZXIg
bW9kZSAvIHByaXZpbGVnZSB0cmFuc2l0aW9uczogc3VwZXJ2aXNvciBtb2RlLAorICAgICAgICBT
U1IgVU0vSUUvWEUvQ0UvUEUgYml0cywgYW5kIHRoZSB0cmFwMCB1c2VyLW1vZGUgZXhpdCBoYW5k
bGVyLgorICAgICAgICAiIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X3VzZXJf
bW9kZSIpCisKIAogaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKICAgICBRZW11U3lzdGVtVGVz
dC5tYWluKCkKLS0gCjIuMzQuMQoK

