Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C1CC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2e-0006qr-A8; Fri, 17 Jul 2026 15:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2c-0006qY-VJ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2b-00086F-Gs
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo4WV2244912
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NdMMhEbDc69DiNKN5npdtwEGSf6iczbzW5UzZR/p13Q=; b=nd7/PPdZL45WshAf
 7wEBLTOLQNLaBy5zh3gE7MB/SA+JSaOWNdji+rM0DLLCx8zSI9/ZGQSw1+v8TOP+
 H186271rGpfbF1C6BYuu6b1+SuEei7n1/EhSWj39VVHjQRa4VxchXb2KEEATqznT
 9HIiqzQ2worV+aXy/TUM/yNTflErBYoqjmHqIc/DJQZhMb2qfzKao75sqOUYmJ37
 JWhLbT43VeGdssspmlfK/FRc5xdyjSy3KjcAomNiPrtRo6LbV0g4DSt0stbzEEVN
 z3jfz+yBA+g9T3J5mrEWrX/XDyz4aGuH1axUUNUeFtVOenUX2+RtTqgPu5B+eGaD
 5VxHAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pay4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:16:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38827cee19eso8709783a91.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315767; x=1784920567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NdMMhEbDc69DiNKN5npdtwEGSf6iczbzW5UzZR/p13Q=;
 b=Nb5bEFCBpoHxVpvqEhyJ5xAQ7ZgIU8fhJJBszRzT7E076yj3OzoTpfMoN+hAUcTAb9
 vpijpLlwa6MQEyYFXLFR39IE/1vdw1MmaIqIQ/BxI4Tn8L7orLvgMOU1RKmlcT5yM/dz
 H+4xfatYrqz885FjrvacqPsM2rWiv40O5y199K+X/7yhL/2o4FHx4x98/833Ak/tzPWQ
 WfnBtwsMy7kjF1stT8RovqS65z8Y+LKJVTygC6PuV6WY8lyhx+FdzzkkLUghj7yPU2Yt
 hN8btfJWa+OkIrjZXImf7UgkTNdmRRt/C2F6lldGd0a1NzIJb3jg4A3hIV86MKx5urMU
 GMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315767; x=1784920567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NdMMhEbDc69DiNKN5npdtwEGSf6iczbzW5UzZR/p13Q=;
 b=PBpfwvUwaaXhk9HVcTiA0X++ehufVmVkbKpHrwfvPX24eEztBDnaYjF7NDfJbTC7HY
 FMCATOaagJOpr68duNqJT97YMpY4b7FAOgilyymDmhpPCbwhQAhUo+6BuD+WuNiJjayC
 BnFSY0Fvee5o9oLHdMWpODgOJXjcNJyw31uAMIBRwMJyanyewxJEF8V6Ei7Pz2D51ZQ9
 xpmKhkdAMZ+VEDVnFiBpSNs6i0SkDEBw34R3QEciFwhu3BImoumQFvuhylrUFHovjutb
 QjLBQq0GVD/eV79nmWeZFNaWSvd9uogI5fPfq3WY7MVl0Md1t+3tOtxwSTDCylnjjtbD
 u6pA==
X-Gm-Message-State: AOJu0Yyq9wKUirh7MMUugiTCqtkTuDp0cpaS0l4JwG+afI7cp+GpcICU
 MzWk4ZeF/Be/n24NzQosiFhRzzlv3T7pNrOXdOnKrbW8ua/W68q5XjdjN1rewlsd4KMHUMSxY8T
 engNF201yLzmr2w3ZH6tNBq7BA36mlxK3c6+R7bJVBHEa/udZx5p6cURg33uqTSh7mQ==
X-Gm-Gg: AfdE7clpr2LtBnNGdtFDIYM2bmlP6MmTXG6OrRkHz4koYmcCJXiP1hjmJwSDpf7EOKX
 EZqVRKK4UOYYVt6mHhZYfkxnM6OKe5JGNQxBTwtTyO1TfLkZLnokuV4FidcqAg2HUoTVsuaQb3U
 Ss7hF6+akTXTXOz+HLKwV34THgRtiLNvPLHhPVRYJSjnqh02EW+lZY7v54g5VBCrrxlPrgRib7S
 blmWnB7Ks5A6tW7qCtrGQvURHgZ9mJgXChXfrcQNirATKv9pSh5DJ3N/u7viUZo/SYsaUzyEDWX
 6GO9UV3+iTEHSXCUh/62uOpGTDMyRZFbjtu+W2RN3MQINXAmkdXClt7AEo3LFCAFA9P6QtFLjrp
 rrr23a5BkbR9a5Vkdnn81DXGdbcp8sM/NY7GHFsSJX8aoFgc7
X-Received: by 2002:a17:90b:2f85:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-38e4b3e1015mr3983286a91.1.1784315767273; 
 Fri, 17 Jul 2026 12:16:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2f85:b0:38e:1497:af5b with SMTP id
 98e67ed59e1d1-38e4b3e1015mr3983261a91.1.1784315766762; 
 Fri, 17 Jul 2026 12:16:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:16:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/12] target/hexagon: fix get_phys_addr_debug with in-page
 offset
Date: Fri, 17 Jul 2026 12:15:44 -0700
Message-Id: <20260717191547.920048-10-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: QWRtnRvDTHKETEvH7uv45G0DUdl92Aaf
X-Proofpoint-ORIG-GUID: QWRtnRvDTHKETEvH7uv45G0DUdl92Aaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX2Ui6PNiiDwAI
 I6fMNF3jPMXGACn5VVySkN7BfVmIeW/N3MGb99rOr2hvgfgVKpwP+DgJz0/mTk77fhaRd14wthv
 axWv61K/OrDKdXANUfGaQZk6kf9O8wZdlLdYtbtne4jovclcmHi9j2H3kraGau/JXYQ0uewbsjL
 JoKcGsxN3vAALWQ7cYqgwaB4mNr6sRXMulWi+YkYzp5E0AxF4fZe21CU6gm3jbWUC+rLGL6NBf9
 2S7ogQnaGcKLMzXM111joovqi8j5ekm3oT2mBvawGrl9SChSIsK+AkXdnsXpBw+sehTSf2nDegu
 v3cAp2upMdV6vRmAGsvfjLGajosIZfJhdEagAu5Y9NBCTWEECcNGgy5sKN8UatFxpCjwPkWA8Vs
 143I3gyixK/k2BIq0mGQikAhZEptvp75I744gJm30FXgKLvP11tnSFpizbNgJw2vJwV43m1ZX8/
 KiDu5zLkbutPhZWph5w==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a7f78 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ERpe_kbT2-JOHJ70sIsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX9wx7CvZ7yFuQ
 wgsC7b38hU7s/Ouk9jnqh4/v1qQtK7PUMCr821c+zHvZwSg6sRAcZIQVyWVQeGOFngR3ECUzUvK
 GBb/gJvHzCM8HFgKHmzENvCW+z/Phk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhldXMuYmVybmFyZGlub0Bvc3Mu
cXVhbGNvbW0uY29tPgoKQXMgZG9jdW1lbnRlZDoKCiAgICAgKiBAZ2V0X3BoeXNfYWRkcl9kZWJ1
ZzogQ2FsbGJhY2sgZm9yIG9idGFpbmluZyBhIHBoeXNpY2FsIGFkZHJlc3MuCiAgICAgKiBUaGlz
IG11c3QgYmUgYWJsZSB0byBoYW5kbGUgYSBub24tcGFnZS1hbGlnbmVkIGFkZHJlc3MsIGFuZCB3
aWxsCiAgICAgKiByZXR1cm4gdGhlIHBoeXNpY2FsIGFkZHJlc3MgY29ycmVzcG9uZGluZyB0byB0
aGF0IGFkZHJlc3MuCgpXaGVuIE1NVSBpcyBlbmFibGVkLCBoZXhhZ29uX2NwdV9nZXRfcGh5c19h
ZGRyX2RlYnVnKCkgcmV0dXJucyB0aGUKcGh5c2ljYWwgYWRkcmVzcyBwYWdlLWFsaWduZWQsIG5v
dCBjb3JyZWN0ZWQgdG8gcmVmbGVjdCB0aGUgZXhhY3QgYnl0ZQp0aGUgdmlydHVhbCBhZGRyIG1h
cHMgdG8gd2l0aGluIHRoZSBwYWdlLiBMZXQncyBmaXggdGhhdC4gVGhlCk1NVS1kaXNhYmxlZCBj
YXNlIGlzIGFscmVhZHkgY29ycmVjdC4KClRoaXMgd291bGQgYnJlYWsgc2VtaWhvc3RpbmcgYXJn
dW1lbnQgcmVhZHMgd2hlbiBpdCBpcyBhZGRlZCBmb3IgSGV4YWdvbi4KClNpZ25lZC1vZmYtYnk6
IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxtYXRoZXVzLmJlcm5hcmRpbm9Ab3NzLnF1YWxj
b21tLmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3Nz
LnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5jIHwgMiArKwogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5j
IGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggZTJhZjczNmE5OWQuLjEyZDI3Y2UxMzgxIDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUu
YwpAQCAtNTY5LDcgKzU2OSw5IEBAIHN0YXRpYyBod2FkZHIgaGV4YWdvbl9jcHVfZ2V0X3BoeXNf
YWRkcl9kZWJ1ZyhDUFVTdGF0ZSAqY3MsIHZhZGRyIGFkZHIpCiAKICAgICBpZiAoZ2V0X3BoeXNp
Y2FsX2FkZHJlc3MoZW52LCAmcGh5c19hZGRyLCAmcHJvdCwgJnBhZ2Vfc2l6ZSwgJmV4Y3AsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIsIDAsIG1tdV9pZHgpKSB7CisgICAgICAg
IHZhZGRyIHBhZ2Vfb2Zmc2V0ID0gYWRkciAmIChUQVJHRVRfUEFHRV9TSVpFIC0gMSk7CiAgICAg
ICAgIGZpbmRfcWVtdV9zdWJwYWdlKCZhZGRyLCAmcGh5c19hZGRyLCBwYWdlX3NpemUpOworICAg
ICAgICBwaHlzX2FkZHIgKz0gaGV4YWdvbl9jcHVfbW11X2VuYWJsZWQoZW52KSA/IHBhZ2Vfb2Zm
c2V0IDogMDsKICAgICAgICAgcmV0dXJuIHBoeXNfYWRkcjsKICAgICB9CiAKLS0gCjIuMzQuMQoK

