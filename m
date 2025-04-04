Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29D1C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0XAc-00065B-4l; Thu, 03 Apr 2025 22:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAY-0005xc-SJ
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0XAX-0006mv-0F
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 22:52:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5341O8Wj016188
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 02:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 czvdxpjQBy2FgdjvVsvcJ/pDTWya3Xl1wmwT9xVccCA=; b=dsGqbfHl1tGYC4ue
 o8biD4+KMclAc2K+qmFjWOyeD0acHUX13ZwaJLpY33iccwHohsIjLhpgIQPlCVt9
 TrYf3By8WbOk+V/DoPv7UDdVbLyVQjsxzhElO/IOobUaJfSRh5cg/prKm4sYiKll
 lRh++WTxziwq7WobCbwk3ypm1HhLdpJVlsmWCCGM4YPnaiz2r2O6pnQvQZgygiPI
 vLwnKjkaZJaCXq5kDZoMVr0hCaswaMLIgKkf19Uu595yx18rokEc0JxU7Sl4j2Ao
 apopJ/tT5L1HuomLpocRVrNdt47v6b0D60aRZpQPivFaQrsO/CklvUCUWBMNTY3t
 qRf5GQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45t2d8gg3a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 02:52:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3032ea03448so1743616a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 19:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743735150; x=1744339950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=czvdxpjQBy2FgdjvVsvcJ/pDTWya3Xl1wmwT9xVccCA=;
 b=FBACGhVI3h4XgcHpnVdoSNsLPz+cnOq686m5sgqwXmaJUPQaPP7OmQe3JATLtCli/y
 rmt2vw2u9GzfeuTDRBaaseHgmGz/S7fWHZ9mWQYH1l7O0oD1Q7KG7zibsmwhAR5DbWEE
 yE6N6co/dcYx8ROcQbvHr5d8+e9YLNoEd1EmAJR/W16j8Wt+/thKWuJlC5QUua4DCgGE
 CCFgkquetxRzP6iYUCbmDpYr8jJjqJQLyBTlIhItFTgddr87MvLSz9iNaMSVo9CNHPwt
 DO/hN/MP6EqIfBUBOOwsN81NI44dEtGzETaa5A/uDoKvZFNJLqP0mp/xDAah1OfbsMvK
 ADpA==
X-Gm-Message-State: AOJu0Yzmmp90iKwV25eunFtpndyciaYmsYZr8FLVlTqsCqHiZ/LrAajO
 OW6MQYWGpnEGxJP6JfolCwjXlRht6bLS8hQyRPmbYMtkuM9McJwBj2mDlhYeWc9YtHEFK6l8f2k
 ii5X1LH9cr+DjCw2TeCKGpuQANu0+u4nvlcTWAXe9LG5yRfIK9m4Mv6o83Ovqrw==
X-Gm-Gg: ASbGnctk9VWKqinJZUky3zPMC4jmZPzi96jxZABuAFqn70fTVkkxQQ4P6JrabYJLd0F
 1fkqGkAwRpakFJTLiIgcUwBPFXjXRCqDuwCjX9GBCekA2V5FH/GN7IrctBqW0VXmjtinQOUFsQZ
 nZbMjFhzy3IiElWDAEBQYOKTGG/qLXIxvmpTQND/xCu30SFncl3tn7ldMtl3zR+SucejbvVX3fT
 f2M3i8yCsQ1o/U1r19F1xczDoB5XQ1xAQzyB7ChWK+Ow3mUtbAlr57CM1mykA03BamH5ExEDkWD
 vBGBISh9nIPICaA5/Rk9YeVrsRiPTR9Dsk9vZUmHMwDrCxInaa+jhNrkFEP0gMVT
X-Received: by 2002:a17:90b:2650:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-306a4821ce8mr2598856a91.7.1743735150365; 
 Thu, 03 Apr 2025 19:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpCvuN06qhn0oo5IVtpvcYcgLV6zaRscaedoxN6rs5NB9KICtubTTD6L+HuYVRR6MEqVRlew==
X-Received: by 2002:a17:90b:2650:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-306a4821ce8mr2598818a91.7.1743735149777; 
 Thu, 03 Apr 2025 19:52:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ea16bsm22014865ad.106.2025.04.03.19.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 19:52:29 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>
Subject: [PATCH 6/6] target/hexagon: Add memory order definition
Date: Thu,  3 Apr 2025 19:52:03 -0700
Message-Id: <20250404025203.335025-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
References: <20250404025203.335025-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: teloBLVnbpkmM5ihttBuD35wgBF2DASj
X-Proofpoint-ORIG-GUID: teloBLVnbpkmM5ihttBuD35wgBF2DASj
X-Authority-Analysis: v=2.4 cv=N+gpF39B c=1 sm=1 tr=0 ts=67ef496f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=SgXgUqScEDldHOCFpxoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=805 bulkscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040019
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Y3B1LXBhcmFtLmggfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LXBhcmFtLmggYi90YXJnZXQvaGV4YWdvbi9j
cHUtcGFyYW0uaAppbmRleCA0NWVlN2I0NjQwLi5jY2FmNmE5ZDI4IDEwMDY0NAotLS0gYS90YXJn
ZXQvaGV4YWdvbi9jcHUtcGFyYW0uaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUtcGFyYW0uaApA
QCAtMjMsNCArMjMsOSBAQAogI2RlZmluZSBUQVJHRVRfUEhZU19BRERSX1NQQUNFX0JJVFMgMzYK
ICNkZWZpbmUgVEFSR0VUX1ZJUlRfQUREUl9TUEFDRV9CSVRTIDMyCiAKKy8qCisgKiBIZXhhZ29u
IHByb2Nlc3NvcnMgaGF2ZSBhIHN0cm9uZyBtZW1vcnkgbW9kZWwuCisgKi8KKyNkZWZpbmUgVENH
X0dVRVNUX0RFRkFVTFRfTU8gICAgICAoVENHX01PX0FMTCkKKwogI2VuZGlmCi0tIAoyLjM0LjEK
Cg==

