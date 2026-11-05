Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2BA606A32D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VLjX2Cv0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PboZIxtn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOsMB-0004xj-Lr; Thu, 05 Nov 2026 02:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsL9-0004Fp-4K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:56:55 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xOsL7-0003pQ-JA
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 02:56:54 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A56U0UC3073363
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 07:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Cp3tcGYniBiPMDJu5eg5RAbOBRqiJ/cj9pbhnpcXV1M=; b=VLjX2Cv0Gayc3j1y
 0ZuHwDGvbqw4LmEt6zYsL2D1qrh3xLTBVJH9tsl8iDpuEnffTtM1PT4ydTjYC0QS
 tizw333EJI1e4jTlECanuesBR/oCaAV0fg5nOJ8N5yYSIX26WaIodqsAUWxitOOh
 Bf5qwlp7+QTXzm1jfPP0fLzTeGw1YnINHn5LbQn5e36wF5hbeoo6CvBrOwj7vR0T
 1Ns/H28/tay3NhZRCTSvxwWNoH9RUtyvmG6unafU/T0kSE8jjO3ymh8Xnz0L4N+y
 kvWQ3bQMlDOg42kJlZLat9hONkY5n++riSRcb8/AmCwC/Ny+RHlHJU2EDpKGfXRR
 5h4LnA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq8h1g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:56:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36d2d353a5aso513929eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 23:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793865411; x=1794470211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cp3tcGYniBiPMDJu5eg5RAbOBRqiJ/cj9pbhnpcXV1M=;
 b=PboZIxtnpJ6PrKOqnUUXKYmepOXZbUNzQBqga1fZxT+4rw1ISRc99wyYXj9XkikpLH
 x0eTw19GbYb9rPG/NwJubyCD9yJK5N6nbK2koTHpYaHWW4ZIlXz47oEx83jGGyCyzpyx
 46p0Iq55++3aMLMnxyRo/M6kCE8T8dcOYnSAIVRx3tSupHbT7DTjB/QtNhueYFZdR2eL
 e+oSRCaUeJcJ0rI9kyRMBfH25iLxI1FKi4AnNjdqz2mbguIkkdUWC2Dpw90MMVjW2Ef9
 GWW2tkpqzG/OzJifyuJyThWaVUckDNkDNvBfoKOyGPyERvXwDrhuM2p0efYLT/aHURtW
 i0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793865411; x=1794470211;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cp3tcGYniBiPMDJu5eg5RAbOBRqiJ/cj9pbhnpcXV1M=;
 b=FHCMinAPzWO/my2qyMStLPIMxNnhQDuxjCBkXX3IA0lU2COO3YlXB8RSzFC/5yV14t
 RGwlNBeViziV/DGxbVSY7oIe5p97uOw4yf07X3W8UHCfaGpcK27sA0ZuQatBjYAp9X4U
 SPsjw5EfpRg6Yk4y9YYUgc6z1FbbvId8WSk9iKfQYYmmhF/+lvH0H/ZDPESirIl/Wxww
 lnAj6kdjpStUeOiSb+VjFChADRFKdx6V6ZJ5REbO0ey+IKW3dAI3YlifkaBYTWu1C55z
 pb2FtD8EhimDoIj8m9lxZSocPMk40VNWCK7mJzw9kp56sEZo+DCKO2k6xmIg0PgJQI1I
 a5TA==
X-Gm-Message-State: APuU4Z9Ykcmu+3ahIi/lDXwHoY/PDtHVX/wB2NpvbGM2dKbPVJPAPtk6
 /nB28XDJjWjXQzvlbPfRjMUoxiz4i6TlOy+q6cdMDrIz9ZzRa6Ed8ZxILHsuVsS6L+Y/49951Zu
 QEPGHEdjZDxbpe5DgS/heNCaaeMvzdzPbZsuYJJ4FmuXsWk3sH0DRDw7OVy+QOYa9yq/0
X-Gm-Gg: AYBFou3rNGTAIxcIetsIlaOhjKOK0ueMkr3xWuLMSKTZfvO7EvDlQugVOPMx79AbaJa
 Yvou9txZHy4DRPle42yUUZH5hUVWkDJWZ20CyqfSx9amUoX43QFqLNfdladcWneTO5xC9/GRBtA
 ErcsApOxuAEPFAnGeHyTJGMb40ogYYuxmR7XJ/LWefRESxpqSn3rcywqimiOQ0ehpxKCVyu7Sjb
 FyL2Enz4SKYkRWjHOCslZVS6ShbfvcBLG81e0wWst/cWdTqZq3YJbmje5T4fHAcvhjvHQSyc1fW
 mnz0JnVvGPqfhmHPCTpUypUf7bV4mkelf40XnbhwojORQnt1wHyYa97zyTrOPC6Czdzm/lFHGMb
 P8BmH0w0/zuBj5WealNZHh8KANr0VE6vuDDalyI5uuH3dXAAaNdZpE74NkVwQpmBxCxGyZGclb/
 qPJACaiJ42pWgvBqqgEWYZTWkphIbvDKgu+UhugX2crQ==
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr2812503eec.18.1793865411080; 
 Wed, 04 Nov 2026 23:56:51 -0800 (PST)
X-Received: by 2002:a05:7301:5412:b0:36d:158c:e31d with SMTP id
 5a478bee46e88-36de6d4cca9mr2812460eec.18.1793865410351; 
 Wed, 04 Nov 2026 23:56:50 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38a6d3dsm17104008eec.7.2026.11.04.23.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 23:56:49 -0800 (PST)
Message-ID: <9448e05d-aa3b-433b-8e30-f1e6521aa390@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 23:56:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gdbstub: reset supported features on Supported request
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 brian.cain@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
References: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261105075346.52926-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfXwWsDdVP8GlLd
 oQknVY17PL5gb6xzL4d3pB0tuen4Y/WkaJvXOJcFFxXPK8suIW6PmGagqVEIhOAmwP7c6ieCET2
 ZLkdrtfMcmRyVBYNKNfyW6waEHX+1zkN7d6zzzKRvqJ40nrph/pSb2hwtAWyiANjNOEXi5S8Hqh
 4yLndXQctEnEkz61TB2d7bobE2Za3xbb5eBbnW5wkGWjyhimhPJSgdtsJnokeXiRZusDovHHsUC
 xg+WS8hOpuxR9zsc3Nljotw038Uu5u3Bsfals9TQnsZpZOxV/CUGnJxsPAu4yZmRYAwcC5JZ7EY
 FvLkIKOZPKC6T23RzuigaFO+BOVnPnixYftzcwim5IvM0zw4WhZl+RMuGqxSMzlOmKxxm0oV9kk
 CFLnGmMKRfer7mlX7zK0U5pKHqLzCbIouH31C2V+vqR+/mv4k368o9empSo0rJMpNJwJTRQJqD8
 u7OcMdm8Gjttcn08/XQ==
X-Proofpoint-ORIG-GUID: 9-wnRYPzZSHQf1Bg_vkeV5mVB5w1kSQM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMSBTYWx0ZWRfXxVMhtLAs79NZ
 a/I7mSEehZQ2N5KpcFbiE451GbD1H/UocdELzIDzTRd232POCgQZXNLjcXcb16H00Ob5VoLPALQ
 eyW+/Oc1HjAPqQX3h/niK2WRxeQzVYE=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec36c4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=CCpqsmhAAAAA:8 a=EUspDBNiAAAA:8 a=lDtavSEJtHVKaDUYZlkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-GUID: 9-wnRYPzZSHQf1Bg_vkeV5mVB5w1kSQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/2026 11:53 PM, Pierrick Bouvier wrote:
> From: Justin Sapp <jsapp@qti.qualcomm.com>
> 
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Packets.html#qSupported
> ```
> Whenever the stub receives a ‘qSupported’ request, the supplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
> 
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
> 
> While we are here, fix the same for fork_events in user mode.
> Simplify control flow to always call gdb_handle_query_supported_user.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 15 +++++++--------
>  gdbstub/user.c    |  4 +---
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 

v2
--

- fix fork_events reset
- (slightly) simplify control flow

Regards,
Pierrick

