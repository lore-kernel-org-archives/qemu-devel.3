Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3363BCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 17:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbiBH-0000et-4P; Mon, 22 Jun 2026 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbiBF-0000eg-Hu
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:11:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbiBD-0006hQ-Ve
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 13:11:29 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFX1P91370031
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 17:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ciREn0d2sjm+w7yRQMTXb7KoJhxp2jZGsvx6rAQwdeM=; b=T8vnSSHb73jQfLwp
 Z2pzGeY1sr26VykFHSq7dK9wJgR/449a00b7KPKG6+vpPEfmHqpFLGk14jvK6i6R
 Z7jTri7URaEODvpqIHqCZEn6wjB0hCz4kDQD5txTuYrtU/3f7PSMAIDfspA+XvZV
 GlJZlAJFTTwZW+LRcdEp293DA8C0KUcH8ZvyN6AvQ07zmrwLt3taCwF9Lso3dXLS
 Uqp115mPtUJYu7mk+yC9RppCMMFbjgDOvnYqfCEgjjBDS2BQaGZaxesP/Htrq7OU
 JsM45ydRS9sH1rfIy07nQHubsi9eEUC92ST9b9YD5GmKywLF1XNy/TscDKOGIZ05
 rMETug==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1tjma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 17:11:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c5319332eso542984eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782148285; x=1782753085; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ciREn0d2sjm+w7yRQMTXb7KoJhxp2jZGsvx6rAQwdeM=;
 b=YJTWev4fjpr01siheD2kyEXgrgh0JntCIhG3WKVLRThwoHoxXOp3JJ3p0M0uvZxqh7
 LQK97T4cY9sYuLWTqAwE8NMZxgmAoKcUiWk2KTpWIjjMbNHo7bXgWX1Q6JkJcYiCEnV0
 VWbNzExOFA6kNftvMbSoK07IMmYT42DsisJKmhnf2Gi9PqqrfrfBF8jtm3TBtewkhxip
 PPItua90lV8oFwU6b2E2EtGq2IJdYVq4z9nvRO9B/3q4NP31M+butzm/NOf8tyPiJozB
 YRc1MOVwW6zBP8IJgdNvXVlhIyV3/fREvERSwIQbtdqJa/s+SMhOqIOrFiNgBusdQW8F
 ZkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782148285; x=1782753085;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciREn0d2sjm+w7yRQMTXb7KoJhxp2jZGsvx6rAQwdeM=;
 b=gsekakOBBtUm9b1xM9PyZvswXIjG06BNgpaRhYfY5FrJyDcdvkJZhitVmf9xCF8q8g
 IV3Rr39OTCK7h+CyHX3nxUKOdqeK6jP1Lt6zF+YkivEfKBEQkc7vvpNdIssPrruEosr9
 upoIZbpDvjQzAZm6lRtrxZ+k3zHKyZ2A4lw3Gyb1n7/xCfOPnzS+rgTuDPDuKME37WOn
 XA+h81a9ZQpKo2KwiEI8aGeLcKUPB3dz2wcpVSOjYeNPyWUnNooXWvYL3PpFG+H8boKm
 bAqY4bJnITn1Rmbaxbnghe97gBQS2wvioys+geHikad6JPZencRGm49n+doFsgvt2vNW
 ma+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RphKKT2OsQNALluhjwdk61h3gjHndxBcauMxxJ3YKNNrJRTVEoAjnFt4WV7l4Q+lf3CoUQKrOvU+HWw@nongnu.org
X-Gm-Message-State: AOJu0YyFdTNtdxOzn+I5IfuzgR1MBFpytGGL2t6j7YT/Tqy4OkLpiWet
 toWJsB0eY3X+nArgyydPnUP1Ji2LY4vT5+XF/330Glb31Jasc/Y/FQCDYAhzL/wiNGAJOCIjmQg
 Wb1caCoTRYeqnZYwcdWALgoiom5eno6u42NGit3e6bRagk2Yb88zLqaePVQ==
X-Gm-Gg: AfdE7clluNZg4Ft8ntpyIaP4mLKgxGLRZXWiv+T4fDHm1WOYD+hAjQwlEO1pAZKbOEh
 oa6VjgDQFndpaAfjINZlscXLQuk+UD3vzRel7DQry7LNB+h6aj1kt9pf7LCeuqP09Ow9W0nZpYs
 Xt1yqfy3+5T8OXFY4vbcCtvoJnXKiyRFtGm7WNAJluY9ZxGYH5j6otEv4auzKUkDpliksyi4/7w
 sqeo1RvyZzAB0woFW4Yk0JqThQefquuzQTc6S7FETkM082BuWA+B2rCfZMa6k/MNytHh26GzCQC
 EEdzOz7bOUQafgO+S9+ViBsmljUycOiAe2sLi5LRmXzpNDNloxD05KecGldeRyD97X0mwR0rYV6
 VbS7CoaC9sgYk6aNMzUlT2MNV9GSyGCp7od9g+8VLLP73Vtyjpalvu01rxJ+/JXEkggjOgA7cJC
 Ez3+M=
X-Received: by 2002:a05:7301:4083:b0:2c7:3a7:c792 with SMTP id
 5a478bee46e88-30c070ee94amr10412903eec.20.1782148284604; 
 Mon, 22 Jun 2026 10:11:24 -0700 (PDT)
X-Received: by 2002:a05:7301:4083:b0:2c7:3a7:c792 with SMTP id
 5a478bee46e88-30c070ee94amr10412867eec.20.1782148284045; 
 Mon, 22 Jun 2026 10:11:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1c32csm11772498eec.6.2026.06.22.10.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 10:11:23 -0700 (PDT)
Message-ID: <00f9592d-fe2f-47a2-9094-377944b183e5@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 10:11:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: use cmd_array() instead of get_id()
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, anjo@rev.ng, ale@rev.ng
References: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NmmGQk-2zjoDSvWRq4p8T_FJGWEw0nZZ
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a396cbd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ZGBDevZQNK6qukIcRYcA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2NyBTYWx0ZWRfX32f8s9o2F/d9
 xPdtqGcAMW8xlV8CED5qRAJtVAf62MG5YuSq4JUS6yRSGoBRKDYa0bwgMU3iDkdG7YL104RUpz9
 iJLe7wxXJcWRzxXqyWyCllFYxAKB5Os=
X-Proofpoint-ORIG-GUID: NmmGQk-2zjoDSvWRq4p8T_FJGWEw0nZZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2NyBTYWx0ZWRfX58i3UQmbd7KZ
 83zj7VuCs/h5FvxUm90TjK3HZbSqroi8XV8U/PT1laPyXOsLG36M/NDKGbUNOMOPh2I1hw8YfXR
 rB+JoP6dPwS7JkiaKcUUDFUlMnbh035nWpl26Wtu7eh7Xn8LMoVMARutofeTjAOmeSaMlr2mlJy
 8X0HxJ06oeRGglv+Uzf34O1d6TPEh3iaFE+X5vL1iGgvwr/v6ld41aUbulCwnwcwZoYZFlmFwj8
 DAqIhgPyhmyqYAeyQbTbO4ggTpeJj3eLkDV9/N/uSCdYh9aQQ3urTrwgAa58dxj0DIZJLvMzCUK
 yvtkhRSnUXEft1aXVMF4FloxJbEbA0Ukn/aKWSNwdx3Kuq4TRKAfHXhJXofZF/o8Jj1DR8R5XXR
 5HMfEUBNd3VaXv2ULRe2b1xghIk+Zt3Qd9QCTdJ5n63j9bnR5rZTvdko4LL76OtDUHd5VF6S7Qb
 DHgRPdWx5vy8bAsI8Gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220167
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/21/2026 10:21 PM, Brian Cain wrote:
> get_id() returns the compiler's short name not a program.
> Passing it directly as the command for the idef-parser preprocessing
> custom_target happened to work for native gcc/clang builds but
> breaks under cross compilers such as emcc or any ccache-wrapped compiler.
> 
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QWzQEgoYMCgZX+9jCvrV6O3RqnA+df1DpT2R6MZvVXiNg@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> index d169cf71b2f..ff22b4e4706 100644
> --- a/target/hexagon/meson.build
> +++ b/target/hexagon/meson.build
> @@ -270,13 +270,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
>          command: [python, files('gen_idef_parser_funcs.py'), semantics_generated, '@OUTPUT@'],
>      )
>  
> -    compiler = meson.get_compiler('c').get_id()
> +    compiler = meson.get_compiler('c').cmd_array()
>      preprocessed_idef_parser_input_generated = custom_target(
>          'idef_parser_input.preprocessed.h.inc',
>          output: 'idef_parser_input.preprocessed.h.inc',
>          input: idef_parser_input_generated,
>          depend_files: [idef_parser_dir / 'macros.h.inc'],
> -        command: [compiler, '-x', 'c', '-E', '-I', idef_parser_dir, '-o', '@OUTPUT@', '@INPUT@'],
> +        command: compiler + ['-x', 'c', '-E', '-I', idef_parser_dir, '-o', '@OUTPUT@', '@INPUT@'],
>      )
>  
>      flex = generator(

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


