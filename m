Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43406CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYiN-0003jl-NM; Tue, 16 Jun 2026 14:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYiJ-0003hZ-Dl
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:40:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYiH-0008Sr-GP
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:40:43 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOPbg3965411
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DYtGAnGIQPqbWhSHLt7X5H6WkbhRXUGspy+zSf7Vb+Y=; b=p71iE0hX3EOANbOl
 x98w0LnMOKj6CzlQkRJWIX31oC/4vlDCjTLJL5NAiZtx8gw4AjNT6uUO3mcVKzGX
 3nITfCrGSitd8zTMG+JTD6/TpRpkCdaIXEequPnfoNLLcC1iwoEJT80VIB5JVYQV
 /BDTzhScJIqSiQaiJnGTYZDQQTK0em1DPpFjsljO+VDo5udnY4bFzThKO709TH2N
 SF7xmK+auPv0cbMIT/lOUPf9KSZv9n5mJLCB2YUmpfUOXa7mYo3RM/M4CiS9GYw6
 ln1r6ZOGCxQFNXB8MS2pc6bZ2O+7Vy2QKCEGMFcxYlwTFG3siDHnXS1Y2WKITWjN
 O7OoOQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etx8kc7m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:40:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f1820babso7152544eec.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635239; x=1782240039; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DYtGAnGIQPqbWhSHLt7X5H6WkbhRXUGspy+zSf7Vb+Y=;
 b=MnOBYCry5EwiLdZxfNP4Zes6PhcgL4+hFm00dZ8uT8iAnKAIgiRdxlbXDk+/8guuBJ
 yHF1Pai1imcKZDBlx/VgMkHvLwtxbTxuX8TppiLFFZ7Yg1WKexlIr6S62rJXJOvyUJwi
 Y+BzBkS/1ZM7JQKSi40kPUmISeq1WVj0ydNc3MQZTVZcxQU2/W9WgFG8Z0dj+httBJek
 VoOkxde4vUUTuWz3F9c//AHlE0UB17MiEUIOiVTtMEF0aEKa1X8d0mEj2l/u7uHyYkcc
 QaXnWW9HJqCJXLdK4tb3MR85D4q0IHwZHgs+J4+7EH9ioxWIN2G8PnrZtvCsqDrU+3d+
 QitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635239; x=1782240039;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DYtGAnGIQPqbWhSHLt7X5H6WkbhRXUGspy+zSf7Vb+Y=;
 b=kfLoURzqOzDAnwcjq2J9bZAt4fk8+XvZK6zS9CANWo8wCrYIhvNaf2y/794DQ7ZrGh
 HeiLnoPm0KrWCEWrahNS6tkpBqk2WvOmiS3qR5kXY8yaxdq7xQeXm9idDCwbe47ojOFu
 mrfGDvhZvXJ2s5/vyYLh30x0ZMA9BiCIAMLnWe9cziWg25/CKywt+ZPWMSbOXWIeohoJ
 YVMyWZLvpg8ynAQVwxH5gKIz8v/WwzaCgL09Ko+itE3wdkViUB4jSbGMb7bugKPqYrid
 cURJredSZQmaeXiqJaA1PaI829eINJS2RL2Foww1fVSwW0MuQOo1fU7R5av0uqUXY73p
 61PQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8isuD3jyidtsWx4Y97+NsWuVOLUW3zIW+EQRwNvrk6xLU+QFrNk8TivtLYC2eXn5VkbzOrNVo/nj9f@nongnu.org
X-Gm-Message-State: AOJu0Yy2FDRf0fYBFeFB2emnqmJ/fcFscRpwUtueVKc/ab1JLKPZqncw
 DRBnYvlcwUwAz4LEvCmJIgvDeie0WKrgGTyqZMZ0aDXDSvqOtganeS5UGPcWMSQkK3v3Eu9vW/J
 cRnN2BqYLFhTYEE12T5MT3iC2k+d5RMN8q5UjIF1A/oRId/b8bHnc20x7Gg==
X-Gm-Gg: Acq92OGf4cPmNtnmJpJ51VSxGIlzIt1sXBxzDZbtjluDW++cp43163+irA0LhVYVcKO
 VWtYbN59WPjpJGLW17Pf9wqGlmvPiW12W6XgA0RWuFc8WL6rexVF/q7tEvyiTzcoteVNVh99KSJ
 U47OwGpq1BKlXuEfLFRzsMAG0Lp45epZXWhfjFhSGoDff1ORwRfek9kN90zd/dvuZg887ECd2x6
 tp7Qca9t0lzTtnTiTZbskzVUDY5yHKK6W1T0blRIaaShKQcPALNNLD1p8K/rVWKzqmlhuPFuybi
 U5dZFWjent5nJnRnRE0Mt8X014p0qxBF7zwt22woLqWvXCKtKB6wH1HtcyZd6kAtpqX4FUoRN1d
 iHUGKJW6msrYGflxZbB45oNXGzMUp+ubl1AWRdj4kFpFoka1cbeuMz2oAcXlOSCmc8nh4TdeB8F
 TVVU9TFslmloVSvQ==
X-Received: by 2002:a05:7301:7c0e:b0:303:f295:4db2 with SMTP id
 5a478bee46e88-30bc91d96d0mr352592eec.0.1781635238857; 
 Tue, 16 Jun 2026 11:40:38 -0700 (PDT)
X-Received: by 2002:a05:7301:7c0e:b0:303:f295:4db2 with SMTP id
 5a478bee46e88-30bc91d96d0mr352568eec.0.1781635238326; 
 Tue, 16 Jun 2026 11:40:38 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb95342sm20497568eec.29.2026.06.16.11.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 11:40:37 -0700 (PDT)
Message-ID: <e7edbf3f-55e1-42a4-8101-0a1c273c7587@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 11:40:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] plugins/execlog: fix execlog vcpu_exit execution
 print loss
To: Harry van Haaren | OPENCHIP <harry.vanhaaren@openchip.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "erdnaxe@crans.org" <erdnaxe@crans.org>
References: <20260616161242.267315-1-harry.vanhaaren@openchip.com>
 <20260616161242.267315-2-harry.vanhaaren@openchip.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616161242.267315-2-harry.vanhaaren@openchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX03ayFKpyY6uF
 bPi+G2i35QNGi3XobnknecU/w3ngrEKjArwzxp+UTZkZivO9i9laiVcJmH+gZOhk0zxc1jb9gfD
 fuuGFo3egUA0N4+ztC4t+zmW63aM5M+h5EyHAOiZvnYI5EUK6GwhmfM8xvZv0XYYEwKT/FeczQd
 0JNzLDxtrFK0NIGnPlxNOe/14OWQX9FYiGbwQbZdpqHEN3PowKA8mE8zPW11zhjNSKTdNKrovZg
 F001kncJzvQ1l+iFkgNsmyZOd+S+6RAtoen5vp9xsXvYhGLKjhigFVMfxrP8Sapo87b4gZtrLDM
 OvwxcFJKcwf6MVX5ife1fVUJEqpkQMqJDnZK3vNLulAaHxd8OfT0q/uypvzw+9ASxvTSlbrK8i5
 UQ2ENlHkXSGBqCKJjLIJBhHh2pyOLhV9nqT5nbvQaTDhY+boTlnTG+YEibXKf8+BdzmPwsoj2PY
 AUigFsUqJKvtWhQu+gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX1BUxPxjHvk99
 gEQqBCoXHf7S+9rCjH3zrFtH+HQWGvW9OSKvUiadDRC0CNdYcOiHT3Tl8KKtjYScff+WhOJQpWW
 JmcrEjGZKbUoJu1r602Af3ezfIXw49A=
X-Proofpoint-ORIG-GUID: x61RuoFpNdvdqnALJeX_KRJ6MU61oonQ
X-Authority-Analysis: v=2.4 cv=dZawG3Xe c=1 sm=1 tr=0 ts=6a3198a7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OZcmDFxvAAAA:8 a=jFOjwzSzJdwwPpuLhkgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=liPxxeoTYnb3ClP5OJlV:22
X-Proofpoint-GUID: x61RuoFpNdvdqnALJeX_KRJ6MU61oonQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 6/16/2026 9:13 AM, Harry van Haaren | OPENCHIP wrote:
> From: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> Executed instructions are cached in string format inside the
> execlog plugin. These strings are flushed on exit of a TB, improving
> performance. This causes executed instructions to be lost when an
> 'ecall' (riscv system call) occurs that causes the thread to terminate.
> 
> The fix in this patch registers an 'on_exit()' callback, and flushes
> any content in the c->last_exec buffer, to ensure all instructions are
> present in the final instruction log.
> 
> A mutex lock/unlock is added around the plugin exit, to ensure the
> lines are not corrupted.
> 
> Signed-off-by: Harry van Haaren <harry.vanhaaren@openchip.com>
> 
> ---
> 
> Please note that LLMs were used to investigate and fix this bug,
> but all code in this patch has been reviewed by me, and I believe
> it to be a good solution.
> ---
>  contrib/plugins/execlog.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
> index e51af9f2df..f362b38268 100644
> --- a/contrib/plugins/execlog.c
> +++ b/contrib/plugins/execlog.c
> @@ -388,7 +388,28 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>  }
> 
>  /**
> - * On plugin exit, print last instruction in cache
> + * On vCPU exit, flush the last cached instruction for this vCPU.
> + *
> + * The one-instruction-delay pattern stores each instruction in last_exec and
> + * only prints it when the *next* callback fires. When a thread exits via
> + * syscall (e.g. ecall/exit), no subsequent callback fires for that vCPU and
> + * the final instruction is silently dropped. Flushing here guarantees it is
> + * written before the vCPU is torn down.
> + */
> +static void vcpu_exit(qemu_plugin_id_t id, unsigned int vcpu_index)
> +{
> +    CPU *c = qemu_plugin_scoreboard_find(cpus, vcpu_index);
> +    if (c->last_exec && c->last_exec->len) {
> +        g_mutex_lock(&execlog_output_mutex);
> +        qemu_plugin_outs(c->last_exec->str);
> +        qemu_plugin_outs("\n");
> +        g_mutex_unlock(&execlog_output_mutex);
> +        g_string_truncate(c->last_exec, 0);
> +    }
> +}
> +
> +/**
> + * On plugin exit, flush any remaining cached instructions and free state.
>   */
>  static void plugin_exit(qemu_plugin_id_t id, void *p)
>  {
> @@ -396,8 +417,10 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
>      for (int i = 0; i < n; i++) {
>          CPU *c = qemu_plugin_scoreboard_find(cpus, i);
>          if (c->last_exec && c->last_exec->len) {
> +            g_mutex_lock(&execlog_output_mutex);
>              qemu_plugin_outs(c->last_exec->str);
>              qemu_plugin_outs("\n");
> +            g_mutex_unlock(&execlog_output_mutex);
>          }
>      }
>      qemu_plugin_scoreboard_free(cpus);
> @@ -467,6 +490,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> 
>      /* Register init, translation block and exit callbacks */
>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
> +    qemu_plugin_register_vcpu_exit_cb(id, vcpu_exit);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>      qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
>

Why not simply make this flush in atexit callback?

> --
> 2.54.0
> 
> 
> 
> The content, data, and any attached documents to this email are addressed exclusively to the addressee and are confidential and/or may be subject to a non-disclosure agreement. Any use, forwarding, disclosure, and/or copying, in whole or in part, without authorization is prohibited. If you have received this email in error, we apologize and, please notify the sender or Openchip immediately, and delete it from your system.
> 
> El contenido, los datos y cualquier documento adjunto a este correo electrónico están dirigidos exclusivamente al destinatario y son confidenciales y/o pueden estar sujetas a un acuerdo de no revelación. Está prohibido cualquier uso, reenvío, divulgación o copia, total o parcial, sin autorización. Si has recibido este correo por error, te pedimos disculpas y agradecemos que lo notifiques de inmediato al remitente o a Openchip, y lo elimines de tu sistema.
> 
> El contingut, les dades i qualsevol document adjunt a aquest correu electrònic estan dirigits exclusivament al destinatari i són confidencials i/o poden estar subjectes a un acord de no revelació. Està prohibit qualsevol ús, reenviament, divulgació o còpia, total o parcial, sense autorització. Si has rebut aquest correu per error, et demanem disculpes i agraïm que ho notifiquis d'immediat al remitent o a Openchip, i l'eliminis del teu sistema


