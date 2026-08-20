Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B76EC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7zB-0002v7-K5; Thu, 20 Aug 2026 14:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7z9-0002uk-JB
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:59:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7z8-0003Ih-71
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:59:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIJ31E4117203
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:59:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ycC3CCZ1GLCgsD6TtIFrSiLadgBWPlTf4lWaRFSnotU=; b=OJHV8DHiDXE1hHVg
 R2MGAXw2blHpOQdgsMvQoGRVvVJsZuXajQIVais0kJQmWNEwhUKo/u6HzpLQVpyK
 2ICMvghe9crhKufrtWWvrXYdz82Btass8Hm3dvVISkcU1emI8WlLEJhf1bl524OQ
 07NL1IO0T2exihvgArQ9aUI3aPpMAAfCxJb8xp4++qFIT9Wv5EzCEq73YE0UG9Bg
 dbm2SoFQc07H8n4RCuEvP58MdpRYKnUdCxy7RwVqbnQmY5J5UsnMDNadrp5hqgHQ
 R8Uviqfa+0a38Ob+/GCwrU6xDiCwNHq8lllTbOUOABFdtNZjfZ/FH+qz2rQG6Ldg
 /wbMqA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xuk2keg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:59:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf42f199so235297a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787252367; x=1787857167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ycC3CCZ1GLCgsD6TtIFrSiLadgBWPlTf4lWaRFSnotU=;
 b=NNmMTWxmMJipMhiLsjqQh9qcDICsfWxUyZ/AaauNyJuiZVdRTNRDowmMqW4jIn7rsl
 FbTQ3Wv7OxXqnXMTRxCwd2jUEyoc/wIac+HOj0XtiRWriqao1jjf4JjcZnNPSSBb+MIW
 S9v0pdU7Dc8lGAWIruaDyfR/pgnpaXOFpT8sO+R1BeUTR56iF673c72c/0jfzNyoyuNV
 8vEZPKMkYgMFDMzIuGPul3YlLL+GI8zQ0nN4vv+9l8vyUA/Ew+ItBQwsKEwtOuFclm66
 Kcyhcho1m7fiRtgI5XwYn1IUs9UDzSMZQUJrLGHR55CvqS0w2qQwcmoRhy3WOgjTx4eQ
 XEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252367; x=1787857167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ycC3CCZ1GLCgsD6TtIFrSiLadgBWPlTf4lWaRFSnotU=;
 b=kp6FLuKqcmhk9A4aM8UIkYby+Hb2GvmeaDCoKE1/zChsLPJsppQEtAj79wmXCmEpnH
 HZfJGmZwE71hrz98e4vSE2FRoDeoTseXoO1W3KYdTJ6DfT3NNVXE1G+nMJEa5ZdAMu+n
 MvmTUD5gMG2SRP9MUhcoj4OJBpJsPEBvZovbyvnsvz7UhZDpKwhmMCQDFf0aXauzCUN4
 FBxI7kVCvZRpPOf7FZvk5sSGUHl4PWG7Z+nDNjaj5uVCaP77DkHsG/xBkMVaz93L+oTB
 EJL7EY8UPE8awbibNsjQIVr/0NmpfwVRiwbqSUU1SmSFRuq1XX2hu9bjPxURqV2tImA9
 nJfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE4ND38kk3KWVR+n1K0jaqNgIKO3Oqz1j1I6/kHSmVO5F2mQ8EAvsDMtUfa97KOUKkgMEB0CVtaE1H@nongnu.org
X-Gm-Message-State: AFuF++mXjk93RMC6nlk7gGjH9iYwsV5PIj/DXfjFi0IvknS0R5WRgn4z
 QCXvST05gObttNE6w85oL38OUfH/a3JDNnCq4LK1kCgEiqiTqpQ/dm8FopaLVT57pmBWZ270jhn
 gyLB2h2GjJkXbJIDBiXuz4a6CAFK9ArT63SQT9xJSeOcEMXSMDJSpuPcuPw==
X-Gm-Gg: AR+sD10Yo28NwpZ/nQqmxiRtHdWtsgINvXe/OAFBUayMu6b9lPnxP8pkBopIAdCc2Ud
 z7ZCDG/O49X0Hl40io3UH63Lz2wsDWX2e9LQgdjFveNs6NYeFNho7X1/lY75w+8DdrkBl7f5Tzd
 ulBMLUvlvzyV8d+NYhcYPaOisOqFkUa7Pn7HAbbb49EiKF/O7+X3CEkgOPQgMsqVt8lVqmlflOG
 sdDQQE9nnTBZie29oE80L+FI8Moy6TGfcH/VYgfHJ5OzZ7lLWAHvF4yFotzckXd+EMw2poME5OT
 4vFw5JB07/I8Xn1IJmFQS0kEMp1zRiD453uvkd97Hwo9uDOv0WAsOd5/4Cb+a4d974bQcXNoz1E
 4JDZQZf0rimDacf7Q0FB5TcaThyC/6gda2VjcCAJXzLtOTghh/agdoGYqPT0t6Q9uO+Pe
X-Received: by 2002:a17:90b:5888:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-395c33e1064mr1361711a91.3.1787252367523; 
 Thu, 20 Aug 2026 11:59:27 -0700 (PDT)
X-Received: by 2002:a17:90b:5888:b0:393:1cf4:d972 with SMTP id
 98e67ed59e1d1-395c33e1064mr1361634a91.3.1787252366999; 
 Thu, 20 Aug 2026 11:59:26 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad699c9sm18756391c88.8.2026.08.20.11.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:59:26 -0700 (PDT)
Message-ID: <c24b0bf1-3d05-4030-9711-5cf5d241898b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:59:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] target/hexagon: fix iassign{r,w} to cover all
 threads
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kS1RkZQwxRgtAsKth_zbUaOMOp20B7u0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfX45zwrExqqGgf
 xZ5lbP8U0fPnGzIcblbS3+uzsapOO0unnj5ghxYPzzK/FkePPfKHrR8Zry/bOHzSGjg4rCVXtMz
 FEwL72+fRxR0Pfoeqv4kbWBcc4TzpSU=
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a874e90 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=gaQTl0K1Djt2Rls-_2IA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MiBTYWx0ZWRfXxaPGhw4WFVnd
 N0NuWbWd0kicMsLPBnlWT4uDcALLukpCVzBYHSVKHWRyhSHwvHzb1kiTMCd0zXeTD3Dl+gHYNWZ
 gZApmbCypk9H6IJqYYxBcXlSka8WPL2ivH0Wwzwisb0xc8JVEnpPU36X2sF2HaSqO6GtYpm86L3
 m586iqDLBctTv3k9wABdlCuTJTo4S+cHmdDYqpECSwCzKh6HYCIYRGhz6HSwy0Qex6Al+W+Fd0N
 nzlUXsJJqsHsZoPicHFj5lF5yWjxz70yIj2CcX7UzFJWAFpYBJZqXxc/Lb0R3r3fimqCyyNhXyl
 aQ7okuZ3UJNrSmMzj+47TbK2vE9cCDksfRaZ9Moq4YRtOCag3+rHN5psdb7pK6VvtiDHJxNxQh1
 TxHCykohCLSaKlnpz82CxuMA+FxvLbGqg0nUuHOlCV8urgnCaq2N2iPvd0M1N6sPmxIMv6RggS2
 RdKfanMrj+MNqHRgI0g==
X-Proofpoint-ORIG-GUID: kS1RkZQwxRgtAsKth_zbUaOMOp20B7u0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> iassignw/iassignr were filtering CPU_FOREACH by MODECTL_E, the
> thread-enabled mask. That mask reflects whether a thread has been
> started, not whether it exists, so IMASK writes/reads never reached
> threads that hadn't been started yet, leaving their IMASK stale or
> unreadable. Drop the MODECTL_E filtering and operate on every thread.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 42 +++++++++-----------------------------
>  1 file changed, 10 insertions(+), 32 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

