Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB2C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHrw-00074x-V3; Wed, 26 Aug 2026 13:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHrv-00074W-BW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:56:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHrs-0000At-Qi
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:56:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGug3u2548590
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wlRZO1BEFbccPyhzIkbiY/9igY/j3RIGRrlKiK1VpyM=; b=cn67KfP2owdg3s6y
 a7wKPOQCM0ZjplmOhe3oxilL0BKCON9osF+3ykUGgfCVTKe6NLunxGtKaeXfm83T
 95D9hrFKly0ZhDB2LDO0I/GTjULMKHUiYR8c2GAzaO4fTPicZCi/k2uCF29UsK8w
 0NLhEY+q4og1HGo2Kw7yI/yD+3MxT1m/lpkR+JZkZTMbvrQDJkI9NjwpgcGeMCaE
 tsBiBXXnnclJcgSGIbS/lQX2S/n/kW+rwiQGRyvYjIieUs04b+lp3mt+m88EKREv
 /Nm9OGo/sZ3GOS89TwlaTiokkWmoaFKBmvB8bFhiIhuFIaoIhy2SGTv5tP5m7ykQ
 iYsxKw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uq1th9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:56:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c19493ac2so14262021cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787767014; x=1788371814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wlRZO1BEFbccPyhzIkbiY/9igY/j3RIGRrlKiK1VpyM=;
 b=U6uC7+BqQkc3wLiyXKchIeDXvM7BTYp+7mlF1w1r72uvTLaVs0Wz1+nzPH5aRILqd9
 oxutDCQY2T4Vim/zTskzeebg44BCQPQLM6WZpON+gLFzsydd+cIEEAVbpvb+1bIlXrzm
 v4VMe81CczxrQiAT8C/nKPHLt3tQiJqEycBvxunMqDllwEH1jzIPaFX8O0HnfNwNq0KE
 IoK/zgTvkQfHisFi1ucI9tIMRwlvZJADiZ5bCYtAOI+USuLvw8bOz+sMpeCZ4aA8zPkw
 0xVMNWaHEzgcl4QXzY1fA4/tZjq5bpTvGs3iO75FKabOLUT7P9ugoGBQ/HLfAomu86q6
 VeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787767014; x=1788371814;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wlRZO1BEFbccPyhzIkbiY/9igY/j3RIGRrlKiK1VpyM=;
 b=Ei+st5E/4UevCs8RQsvR8A8PyH2+pC/gxV5e2z+s9qxbgk7XOAyZcwlBzZncj9erOM
 hMqHdFg4XwlPpr+sV4iArq98WZrNEZHCNhADLGGKbqCS0s8r9ymoA1kU+rSTAH4pavO1
 ml42xnZWC0D9pyDokK3CdVMXJHB1+RKe/idvuxN72djVhWg0AJx0+hHdacfYmk+qHY1V
 0ouwIn4yxOPUwCG8AYbXBxw3IhVVLB+24P1AAZLy6uGAZeaU7WCycgy1YizDLXhEeYvn
 +IM+1JDxBnI+50Wt7+EMBbBBp2yEc2WbNvmdxZhskZlNy6c9/rcPMoEAJ/YuuROVKrXV
 KsSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkGrHIiSwHeY7zgNx/IYNlphBFnRMLTOG2cuIZoZ15EP8RrGm/h75fhhP5FDnpQS295hZRsEoFRzJo@nongnu.org
X-Gm-Message-State: AFuF++m+68oat9H97Kx3zVGQTC8Ua+3K4RKagNSPKNMHenRoKdR6zBOv
 Gp8+AnGFyx/AEDUw705MVPLOBylx6oFEtfWlA8oAWAPW6NBW6nMEgU5kMx817tXxf/9VAxm9NSZ
 d7hymwiyhyoSe5sT5qh7V8dKz/TKLw8vlsxtPrPyGXyU3JLBdV5/BBVSPwg==
X-Gm-Gg: AR+sD10IjRrfgIjUeBeRKTMKlvg1HmvypDq0HIKAVUIAlzZ04EZ5HIblKngruFWNyjF
 +nifLJ9qUmbrgtK0Yd0eA9SwZb6QpzGzUR3XkUL9bXvDXnFvwQk/0HbREG1gPyYTqS34WPo6KRm
 7yX0AMbuH1+pXvXTBsV0PUFb2zQadJ57c925hpVYZ/ZTVZ6oiIYByqy+QiDDKr+af7j9shV4TF1
 lwDLTD0KN0TnH4F3xjuCTHGu8AKctTbZmmaSP7y900feaE65OLEwmXqsqkHV+3vb5zOUbqOOQZF
 lJoZR6Bm7JkrZ/0i6grWU4JjoZ9wGbV/kWD6ld6bHmwbklqboJtlcrd5xquwktulT7M9x5+ehbk
 eaG99n7NW2HADRfoGkVTNdWe/RUkyFDRTkUEej9rX6y4=
X-Received: by 2002:a05:622a:588e:b0:51c:f3:34e3 with SMTP id
 d75a77b69052e-52e42330005mr100826711cf.28.1787767014006; 
 Wed, 26 Aug 2026 10:56:54 -0700 (PDT)
X-Received: by 2002:a05:622a:588e:b0:51c:f3:34e3 with SMTP id
 d75a77b69052e-52e42330005mr100826291cf.28.1787767013561; 
 Wed, 26 Aug 2026 10:56:53 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d62dfsm582664166b.4.2026.08.26.10.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:56:52 -0700 (PDT)
Message-ID: <2476f46a-bff0-42b5-a955-9741695d8a94@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/49] system: guard HMP initialization paths with
 CONFIG_HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-27-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-27-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dtNuuxz-1cgn4GjBNwo3ZFbj54oD0Yka
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE1MCBTYWx0ZWRfX09Zg5Tlzod+h
 N7Sf5Jq9CUPUyR4lTNeZTu+yE/nOSi7OZ2gynpturHV+66Mol4eRnYzJUMdj+LO0XT5XHO73onL
 EjWqXcgvkZRN3UwQh4D2CRMrKoy/J39iI0zR8ia4yS5ZaHcuPRfdIY5Cn4oKicVunIBX8xE0WP0
 qUnfUeS4WCDCNATRVwodnoHjdNOsj1fsxx4uRL2TGSe0pVxll5EhA01cXh3WXyC1uls3+majhBW
 uWfGInfUj5jGTYJBui/Q1d0ALZW4CDJpycKEPd6LPm2zP73bFy+LOx4G2g23ybd1jCUXlaR9DRT
 tu8k14RkvVaSLlL1NBNnMlZh4vZ5UPEq3xLaY4JLm7Kzch48m4CRRHyn2l+dY3TUBz9pwcaIDn/
 5sYxTWPkeauZr2Vv7niXkP1/L3e/6n9hoqQC4//DYm68pPKJb1WjrITWtbf+OhY1oWaqY/Smn1i
 E7KA31OK68sqYoSUyyA==
X-Authority-Analysis: v=2.4 cv=Y77IdBeN c=1 sm=1 tr=0 ts=6a8f28e7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=e_1ta-d39UCIKB5p7w8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: dtNuuxz-1cgn4GjBNwo3ZFbj54oD0Yka
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE1MCBTYWx0ZWRfX1Pvg3Fnhjm6R
 GdGCkit4Jh5GALGZfSnY2o7LkWNzlSk/NIPZ03kZTEovQYf3+qtUHmqNX9Wbb43D1BHcvH1d4N4
 0aXoVuD9+vHd8NKdI8HNIg82uDp+ubk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260150
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> - disable default monitor when HMP is not available
> - hide 'readline' from -mon help text
> - error out on mux chardev monitor when no HMP
> - skip HMP monitor terminal for gdb, return E01 for 'qRcmd' remote
>    commands
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   chardev/char.c   | 9 ++++++++-
>   gdbstub/system.c | 8 ++++++++
>   qemu-options.hx  | 6 +++++-
>   system/vl.c      | 4 ++++
>   4 files changed, 25 insertions(+), 2 deletions(-)


> diff --git a/system/vl.c b/system/vl.c
> index 5ccc19282ba2..760cf6e7265a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -199,7 +199,11 @@ static int has_defaults = 1;
>   static int default_audio = 1;
>   static int default_serial = 1;
>   static int default_parallel = 1;
> +#ifdef CONFIG_HMP
>   static int default_monitor = 1;
> +#else
> +static int default_monitor; /* false */
> +#endif

static bool default_monitor = IS_ENABLED(CONFIG_HMP);

>   static int default_floppy = 1;
>   static int default_cdrom = 1;
>   static bool auto_create_sdcard = true;
> 


