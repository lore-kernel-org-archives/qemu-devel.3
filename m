Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5247CFD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaB-0001jt-BS; Tue, 10 Mar 2026 23:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa7-0001hI-JT
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Aa4-0005Ft-IY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:49:59 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3VKj3614148
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=; b=kN2aiifKz+v5m090
 QtE7DUtcrl+ukrN5p2pxw6/63f8RmetQCHaFoSU9j7FIFy7Owv6UkqFSm5ENuDeD
 DutQP2cOL2xgxUXSSVAkqlkgzZcLkD1PojHO55b6/Zplesm6OpZ1RtyQh1afPzYj
 k97i2f2rnc0MnwE3oS8y94thnpM0Ga5R9ec3Xq5CKOQ0iniRl6sWcu6tyQuZVCyf
 HXBW8DGS2jSM0xijN9rKloOdnu4PfB05sYaoWEjhKfmoMv9jmptUMoJ2X/U7jDux
 w6liUb1gIKBi59/IblxpghPq6Jr4zi1gJ7maj7+HQ+nN6P0y/MP+E1LbbY9WOPb3
 Ra+usw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cu0jf01pe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:49:53 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d75b6b8500so14278572a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773200993; x=1773805793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=;
 b=VdaZZiJGqkgeXn9JwDGyKhPSyDbhSl3povaSaMY40vYYgiRWBefiP2PCnJL3hjan+G
 bsL6mlcShCVNmBISxdaCuLrqSXHdXHR0I43tV4kqv1zelNfutfM2mS3fRJiClKAlsgFm
 MHQdy3Dw1/XnpVDAPA11qvTa8sA8/SfYQ7u/IeHzmQZ2/TgtGkKOFXAE5Jh9twxdUvFF
 kHfAA7ppFWdqRzA+eC/E+mmB/b/bVuwOEU8LfP7jvSiykUiF2T6mw0Ar5wmGowDHn1iv
 x13uzDvgpkMFNSCdZ8n+YIq0WfqbjR6bW8CNyhYvU7fdyDFSXvanWZx7Zt3YaBxBQbj3
 09HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773200993; x=1773805793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dEKo+PI+5OZkA0WTjHJsLVTWdm83mUoo/A8kK5cS4cA=;
 b=BVhJem/3zV/hpZfzjYZxeYceNNv7J7eKb0d24dwhGI6kNOrsl3Ltbui6tXkLF3pL2t
 SnEd3osyTTCbhuXU66nj87KTAkdAuhY7jHFAqcaFOVyhmt4AKYgRdvnM0GBxZuSrlbd0
 OesN3HdSN+MXkFoX91erkfwgbd9PC371OeCMVYYzboWOlFMDybLqVppvGaytZOx+BQfV
 y5B9Fmt07buUcppxU21mtwUtT0eqWhWhEB9AmVDiJeCTG3QjtcToHtAtVYiq7ofIi+Av
 pxe2cVQFlC0i+3gJrBhIbr9PohrmOfZbIgyvRPhAyu2oy1F3pCcdfVceMuq+HQQYxCwA
 j3hQ==
X-Gm-Message-State: AOJu0YyskxP8v/9m0J/n7FgU8BeVEzzrVlcrKYqflujtcyt6stnJeAHj
 GpzVsdfEhy7FdPkhvkPrFW+p1++NyWjwf+IEoYOLgQs02aG8lfPhchKz1dPt5+EieAac00eJF0Q
 VRUxK0HgXpW7EAWb9iLaOoq98qgq2k5LE0xiD4bgi+JI2t8x+MdzE0NEV04g4Kp8Wdg==
X-Gm-Gg: ATEYQzxDp/Su+AE3BhuFcfCTU+UY/NlPLwW9PTeLuSKDoDgHofMJnKWUASVtJMxupPa
 GfO8677EfTv858StUFKLlvcnjYFZsCdCC2ZV8fpzeeW3J3fE4NaJ6A++lVLoaRcIXUVpfm2pObz
 H8ah9G5H+Uh/Iteg2k5weEtsaHJeCJUOeD+ZGLQ1voO6QZQIjo/AitoKtX8YGxWPVlbU7yXJtj/
 xs3rC5caYtFbETER7+5Yj/7LRTS9hlBXirrC4icQeCkfupOlsqSi/0Zv6j2XVLOS8oCAFA7Z2ic
 PkbVmIFQKystTbjNunQDcMRHSztfhDZLk6CQgIiCn1N/45wrQ1x4YZo0zffyxPt+lCiz1nsmymr
 57sE0jmOlW7CWbRZxtgXTC+FveVDFSP+eQjTdAPg1g+XVL6Pp0WuBIDkhobHZP86yS1FYyA==
X-Received: by 2002:a05:6830:4988:b0:7d7:4b65:e8ba with SMTP id
 46e09a7af769-7d76a8b098emr850774a34.26.1773200993131; 
 Tue, 10 Mar 2026 20:49:53 -0700 (PDT)
X-Received: by 2002:a05:6830:4988:b0:7d7:4b65:e8ba with SMTP id
 46e09a7af769-7d76a8b098emr850759a34.26.1773200992822; 
 Tue, 10 Mar 2026 20:49:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:49:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 20/35] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Tue, 10 Mar 2026 20:49:08 -0700
Message-Id: <20260311034923.1044737-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 9zdMdIxWo-1M-W1t-2zLfs-WjHr8CyqP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXwTs5g8T7rA2C
 YzOJZjd0aiCr6XkznjPf8Fzx3VC26vCgF7Aj4CS4KkYuffcNCEnrXXn5Cg0wm5YBxCkPegOGwTw
 BRgJl90+8mxNS6N20D/GKmXYSHyPmEpb0NNa/7jOwT7eyQsA1YF1pk+pfqSfoeqA12vzChcTg0V
 HLr6/FfGodsNJgOl4SkjcDcMbQzMkKAbg4Xzy7VQO2T1DeGIx0MU4Govh56bMgI2KlqWPhIryc6
 OH4N8G86fF7ESyiP1svqEA375Nm2JtzR/uimPm3hOuRuVqKGbob8yiddoL5fwNFBotoK8Ns8iNn
 L4N/LYJhaEMzGOY3SOswVtRqqt/ac3qVx00u2srfNJcw19wvhxbZAwquR+GEik5SA87jjsUd5/c
 msuDSLy6EvDHAZRJgzWXwb7JxYR2TKyAqaeCsUCOXkEwdE6AQT9J+V5Y5bwro/0j9kUHtVEZM8n
 6msZEySTF4a8E5Mq+0g==
X-Authority-Analysis: v=2.4 cv=FMMWBuos c=1 sm=1 tr=0 ts=69b0e661 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=8AIcS7dZ67HrSpPWHdEA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 9zdMdIxWo-1M-W1t-2zLfs-WjHr8CyqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCAxZGFmNzIzOWZjNC4uZjdjYTQ5ODZj
YTggMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIvdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMjUwLDcgKzI1MCw5IEBAIGRlZiBuZWVkX2Vudih0
YWcpOgogICAgICAgICAgICAgIkFfTE9BRCIgaW4gYXR0cmliZGljdFt0YWddIG9yCiAgICAgICAg
ICAgICAiQV9DVklfR0FUSEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKICAgICAgICAgICAgICJB
X0NWSV9TQ0FUVEVSIiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKLSAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSkKKyAgICAgICAgICAgICJBX0lNUExJ
Q0lUX1dSSVRFU19VU1IiIGluIGF0dHJpYmRpY3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfUFJJ
ViIgaW4gYXR0cmliZGljdFt0YWddIG9yCisgICAgICAgICAgICAiSjJfdHJhcCIgaW4gdGFnKQog
CiAKIGRlZiBuZWVkX3Nsb3QodGFnKToKLS0gCjIuMzQuMQoK

