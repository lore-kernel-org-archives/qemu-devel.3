Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F114C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBnd-0004cP-8y; Mon, 29 Jun 2026 09:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnb-0004bR-2y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBnZ-0003DZ-Id
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuMq2640872
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=; b=JPRRK4+UrF+l/Rne
 Uw7Hc8GQ+DJfv2hajX6xsdkm5+kF/sUP1cv8+YOnYJsiQKHlGjRB5kuCw/D4RMK0
 V/G7PYv+XYOFToKBymsxHrHYBiRARBF6QHzrEQbXAhlfzaeImr2CqzYOlSUd5ERJ
 J4Kq0Ehf6oqPy0L6GqQqKuCr1++Hin8krFTlagbxgUNzecIBAT1VspYRyWa3ZIId
 I5jVPJExOczAM+8vWAy0eqbL6at5ihgXgFdoupvrWZnxehoWpI3JQBDXRS4RJX3g
 GlNO6vpt5bL5msOBsb8BlziPZM81Jl43y9kBkOyjlyM9ovdhB/yhHanHQukASfGE
 7KH6Kw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s1433-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:16 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-138acbc0e69so16085131c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738795; x=1783343595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=C9U2Ry1SlhHjhg3y0i6dhNHKX4qLFPgceIT4a1sIqKV7g0D+3+SDnYE5EOQbVNixFX
 Y0f4gX0Xj5100GpFYSzexWIYtKcp4ABoE3VFL7f6+q42iy+iBwtZbr3RGOyl81PeCFvI
 YJCfju+lck/qlcMN+n/qxfmLV8IRczr9qRFwSjKet0tmi0QCTrppYeBRUdsyo+Sqz/i+
 /UnHNMEcnzgjT6Vi4yrJwmccWhs5ssDPHGrnKaSjWvpZqFkH5INh9d8BEFNTB+b71pzc
 JKU/7f7alyiJxPCF1S2f5fTcai8v/nefNt5V7mU/Grpen3BgQTo1VTd3sF3i4oY8bQyu
 OuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738795; x=1783343595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YSGjopxVE+rdAilYCXMYF1ogegIN4PeOYEB5C/MYTiE=;
 b=XAuSzSj4/P/R1+sccVArKZ0118YVYKNswfiSco4Ey/5BVX3WDlJkngz88GXwncu2k3
 7Mc45RLoKMuAg3WEwka1K0XCrGQ0FZrD6sa9FEyGzc5UC2U5CnqRZ3oZ2JwEiV0Qm1CA
 VHz5ZDVnXUBka8lpNEkMuj53aSL1QH+ltyj1aZwpAk5x0i6CzxoD+QXkjsFogAh6WcO8
 9fg6N0sYqxeqOkBSK3IPMS8YYzjdcu/b9zO55Vys7kr2ZGbRGe+VqyexvJAu7Hr3EURP
 4Is42VB4wEDgOco7V9ENZEaTpTFqRAjkqzPZQXqX+DXAhxaSe/1TrZ66HqvJcsOGGVc7
 LqIg==
X-Gm-Message-State: AOJu0YyRqxsK8C3Jag2dH1eqBqpqKYeVz7jozdDf8R9OSh4Gz1yIwf2/
 WHGYRiDola+04RtiWO8tjK4EqxQ1tTITq0d8kt6WxHhpQYBjirJ8PLgdRglF/yhvVK6O4CfY2TW
 jPwLgyaMqL3vpc61U+5OACMfPj/wmUp80P2TeKNGCOFTQoZwBrjb46XOAfNtWxtt80w==
X-Gm-Gg: AfdE7clYCbeR4OFpv5LhaEdhNWkEr/Xm/WVFo26vJXacgIOOzblRYu9hc8talgR3UpT
 g1cEQW+HMIYCyGP2MXoEhzeS6CjL6g7HrVQ5t7UmOVh512XgCw4y4LFH4wh6LbMDK111s7FdURa
 kmNXsE7woorTLItH/lb9Mm4PNMOibWcaclKoPqzZnl5unojTLMLYjEW4/4agPgxY9FpMYlWgpVd
 HdOm0wkXZ+VCTQk8gW9zPYv/EJ6cz77QflntKJvOD4g3Y4ex0ePA8ayBmou9niWSKiiQsEh8BcJ
 +vdKkg0Ce3bLQv9Bxh6A5u44QXoYWGuWw2CwcpRuukVovoBtuXHp5Fu1IMO+euDdFsxkoUBZ35W
 5HeF7rlfKcPeGr4rS4WWXaCyG5yTGCB9B++S6h/sqbqr1lSNClWlkJlMKgLo=
X-Received: by 2002:a05:7022:f85:b0:139:d923:f8f7 with SMTP id
 a92af1059eb24-139eb131a68mr11196963c88.4.1782738795558; 
 Mon, 29 Jun 2026 06:13:15 -0700 (PDT)
X-Received: by 2002:a05:7022:f85:b0:139:d923:f8f7 with SMTP id
 a92af1059eb24-139eb131a68mr11196934c88.4.1782738794974; 
 Mon, 29 Jun 2026 06:13:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:14 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 23/77] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Mon, 29 Jun 2026 06:11:38 -0700
Message-Id: <20260629131232.2487780-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX4IMp0sCwtKi7
 j7Fz9zUA/k7P8+WthUlN5ShMiyVNBccvPs+q4CXCNVui4JRymUaczm99f0ogS33PgHNs6U+aws0
 MjR7mCQX2YJvFyWSLk6TnVTeDni+oHA=
X-Proofpoint-ORIG-GUID: xfjXwftVd6DSPnTqIu1FRWswrXiwm6r1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX4ET2mRiVDCql
 B2k8QVGmlDeElOTYvOdNZSfCKcC9q6o3FHR/SiBDfLzEDgNkwcHLTFPsu7DfhAYbmCHxQo9o58z
 tIXrb57k75BTOWb4h7FGDeMXUJvYgWz5cFniGH74XGq4hz/sg3Ehvh+LgEBHOslZU04WJmCtJfz
 NbsKSde25TTxqI+7oDvhh3PStUn6SnHmV5PSXf1H7OiaQe/kRtBb/dortX/sq5iFsLqHijOo/C4
 PKXJ9mq80n50lvQr68ti+oQmnxNh1vy26Ya2NS8QnpwiNfyIz7g9HUvE55ZZplymgS6YZOX9Xvy
 s8JXmrTOJRUnD+UPc5yl+mUUmvmRxOju600KPeBk95FuRaNDdrydX0hPkeLMt3nRGZJ7+S6LIha
 agcXWCmOLd0vCVaFh72u+VG0OWH7x5B0MG9W/TzXjNDaVI4Xj1yZdyajUHHY/H8PXABbPUkeKqs
 mwflgd7nbUDEgGpByuA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a426f6c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=923NME1-z-asBZaYXDoA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xfjXwftVd6DSPnTqIu1FRWswrXiwm6r1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCBkZjhkM2JhNjU4Ni4uYjU1NWUyYjY2
M2IgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

