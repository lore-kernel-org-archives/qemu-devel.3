Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18463C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHJZ-0003wM-UX; Thu, 02 Jul 2026 09:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHJZ-0003vi-6k
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:18:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHJX-0000VY-3W
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:18:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0ZFi522867
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vB080YwELPRleAO/NKhwJIvIMuGmfsvOqhL8wjmfIYs=; b=D6CM0Dga9GCnQtTf
 oCZXKMypC6AoEs6N+mOhzwHp0viF7q8Gfrc5cksRjf7trUFcepgrweQ6CdaavvZE
 4YeLh41V1FLsG991ur+9xZ1CNhKUmUF0PuUHlAciGCU6KT7cDJLaGJo+U4tf9SCm
 HuH3Ae7IGEMwUdL372g+rMhbhFAHE6D6dpr+U407XP9JFxbFTvYRSHUlT1xIENPh
 7z+Tiycf+Kft6t2iMwBNGuXsYTqDZkG/f4T8Uhrg2uTkZ/eQE2P8oZqB+hhUFzqu
 XR0X+y8pL1FxnsPkGzQYDRfPPf6kAqbIPZ0wtHZwbeQO4nU0Okde4pWhCmX5ZiPR
 MWvgRQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vvu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:18:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e52306621so171229285a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782998325; x=1783603125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vB080YwELPRleAO/NKhwJIvIMuGmfsvOqhL8wjmfIYs=;
 b=eMvtM2yDlRQV04EFY6ComxeYRzKmiWFyD8h5AmPqReG2f/IWzO4ho0M/fpDRZ0rAY6
 jZFJ5hLX9Mg54f1Z4zlBKQDJD33Xor6d2PeTbbVmk6MxY8/Ci7V/jQPrnSKrFfwEsOve
 KpPZHLzy0kJyxx+dY50rUmAmHx6a6BJM74kwNM7FzaEluqglGAGN3z0Cm2hmVpAeFxbY
 Oizs2esEnTtz2IfYcF+7dwZ12UdcZgs0SmCo5ADCNGlmOGUG05sYhN5S1mqL3gYmyMKQ
 OBj2JNylpaeeb+gOdqBSx5wHBq4JdGV6Slct7dZ7DCUqfZeYGT2M8ojlU9/OKppqJgZt
 isvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782998325; x=1783603125;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vB080YwELPRleAO/NKhwJIvIMuGmfsvOqhL8wjmfIYs=;
 b=eYekLap+EIGyFY4m5QnRo+3SY7NVZnpXT69YSVzOV9wrTyE+m+ApXyPlyZqvz222Mm
 R6GzZUm+3RDGzQgDkQdM4n2kpgca8XTMnUTVJIT/qfhou4u4wUhDhmoYkhi9FjyqK5cs
 DYwhoyr3nMsrBoQ/gBt1ehV6DLSBbu4fH0RnJy/xADXq+W1r7Wf61nRItkjy0mCGQJM6
 Psglud11OJHIaJVp0gJ5wY5iHED+slyjOl3GI0CHVV3zBeuLbM3ca6lr/3mXv2cvwbKG
 h8i12hojlUPcxy8WjiAi0CtY0/H7CaS6Fput5o6L0DQtyRvpiHTf1COLbiVSQf3q/+0b
 Jbrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BVh/3et7kAMGPQREfmZ4pLpKUoIGni+PE+alntRW5MX+2EtBgU6dSgRZ0Z2n4D0hdgG1z2hh9WgnJ@nongnu.org
X-Gm-Message-State: AOJu0YyAUxUOYaaCv4BGoTENjtEANQu/jj3XsYuCepZlSWBx5f1g7nTd
 D+UsLMRA+Q62gfjdyIA6CPYfkK1AUlvMYswaxQHi1Q71dXWrJwiG/JKiEw6nbdAGfRtoy2rKlKr
 YriaBzCuB3073Lxd91jJiqXa51xV9uUEhNj1he2sN/GBmi4B5Ro9BoCmvnw==
X-Gm-Gg: AfdE7cmYdUa/4ACXfXLAMWZZIAcu/fNAsD0CjnAyWAfGUhw/qrJ3nzPKGnOsj4mqpVg
 VZ2Q2iSjQuwQ8l/YKQ3vFHZWdI/eyRKXgDgd0gJv63tjoUB0aVrmoKsP0zWLfD2gX6bkxOgeBsV
 t2BI/9RaZldUYmvts2dsRma/k4QG8LEEgRvq3b/kKITJlEnRqPf/iSZcSmEfdw3+qlkodXj+STY
 qTwXRLNnL6o9bcX8Dd9oSSyJrs9kC9hiyH0Rqd1JtukpH626sqH8sjlQif/2PxRmJp8WjzMtmJu
 mN+vDb8y+6t5HakFIlf4D+8I/d/gdgKTV5p/EiVQUVC50aqEGzD+M4WFXYxWNyki4Q1dRDHdbj/
 wafceHPliRXCiAYCUoRzOwgY596+CULr6PAfOtMgjewCT
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-92e781cde5emr766297285a.11.1782998325179; 
 Thu, 02 Jul 2026 06:18:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:92e:6a43:4768 with SMTP id
 af79cd13be357-92e781cde5emr766292185a.11.1782998324614; 
 Thu, 02 Jul 2026 06:18:44 -0700 (PDT)
Received: from [192.168.68.106] ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e80194a13sm215723585a.38.2026.07.02.06.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 06:18:44 -0700 (PDT)
Message-ID: <ba9598f3-7216-4483-a8aa-05829d077235@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 10:18:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/33] gdbstub: Only return E22 when reverse GDB is not
 supported
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-8-philmd@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-8-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HivxKbTC9tecUZUWN-XREQ8UjmCcfZNw
X-Proofpoint-ORIG-GUID: HivxKbTC9tecUZUWN-XREQ8UjmCcfZNw
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a466535 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=8MWuJb2oL1_sMAQGeA4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX9brGzhtb/U0w
 Q1OVcAjN/TFWzPdEjwhM1WixnU6BbjVlEoUceAjbRFa0jys3FBSt/+rnVAYOwonHnDtK0GxaGQW
 fyTpuUaP0sLCTpMvsIhEpeXC7xufODyB+8sMul2mVOyAVpWA0rR7BBTfhtg+VboESfEdMQ+9rUQ
 OoNp60N8YxdfuMmq1ATHRzkmvteOgaf5kjudfVrxzOzOAzCKikc+o0jUOX2p0T9LfikvFaSPTQm
 GDyRmF/9PstCPMg14yYXWJ9APOXm5xt61TgtWfFgjD1RrB6iWdQcOHWv9qsLoRz+WcGK++qjdQf
 XnakiZZpRHeQMtsYk8BU0UH/chW0rPrvL+U6wrtUZ4JmLAjHeGSPeaPaTPVivR1sO3hr2CIolIO
 nPwTd7+H/S3Z0z7Jp0Bdu6jUbrB6BhI35v61cdc+5BZASJCL90nXhFJN0isPt2VTU10wROXhUYf
 ngq4tPbfzTHHSTY3spw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzOSBTYWx0ZWRfX1PcPSceY0zmb
 leKoR2T7opmhTxWcnK+faSwODDE4o3FiyEJtMfd1zsPprpZB0vqLe/m0eJRI6oz7Vqpa7H7P45V
 26lITX7HeJe4X4H4ThCF+hxv75OYpqQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020139
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/30/2026 7:00 PM, Philippe Mathieu-Daudé wrote:
> No need to keep processing the arguments when we know
> reverse debugging is not available.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   gdbstub/gdbstub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 246e7746300..f54415a9db7 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1378,6 +1378,7 @@ static void handle_backward(GArray *params, void *user_ctx)
>   {
>       if (!gdb_can_reverse()) {
>           gdb_put_packet("E22");
> +        return;
>       }
>       if (params->len == 1) {
>           switch (gdb_get_cmd_param(params, 0)->opcode) {


