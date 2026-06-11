Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1089CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaOK-00023i-DU; Thu, 11 Jun 2026 04:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaOH-00022m-7j
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:03:54 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaOD-0007cE-2y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 04:03:51 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B83fPJ066933
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 17:03:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yVelrb7tmO1qKhdViVmiDM/0urShVpMs6TDm/RqB9Ks=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781165022; v=1;
 b=F9AL+/MkLLGUf7K+ev5jm9ZqTaluom8zcxGpp4s6dnbom25ai+S6nypKTbS/lNTn
 IOlff03hk1x/gayhqtbWg+Z83nvBVFowozi1ZCVVoRfsO2wiNmRSxwYl5ImBR1ey
 vaBCtEL3QwxsO/CHRCFsU6n+zf/PobElJEC0w6Q/mORekDbNZPKMNWE+WGTgqBSa
 YfLBVvhMzF15D8x/WFk5H3lWUfS5TRf4e50x0ym1MyDhwJFlnRknRnC+OR0XweHe
 rJ8ljyGBRrle2p6GxKLGclPFFSSJVvyNfzExj+n5qatlKvBKU2ysRej9BNnIp7KH
 cLcXkkKdMw2B/DMDs3pgUw==
Message-ID: <38dc61b8-bbad-46a5-8e47-e6ad53be9fb5@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 17:03:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] ui/input: remove dead declaration
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
 <20260609-ui-input-v1-8-42615deb818e@redhat.com>
 <b7053e5c-f2ef-4037-ae93-c75adfbe3d92@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b7053e5c-f2ef-4037-ae93-c75adfbe3d92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/10 0:15, Philippe Mathieu-Daudé wrote:
> On 9/6/26 16:34, Marc-AndrÃ© Lureau wrote:
> 
> Fixes: 0337e4123e6 ("input: Allow to choose console with 
> qemu_input_is_absolute")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

> 
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/ui/input.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/include/ui/input.h b/include/ui/input.h
>> index ea2d944a7ed..6df8ae3a8a3 100644
>> --- a/include/ui/input.h
>> +++ b/include/ui/input.h
>> @@ -100,7 +100,6 @@ void qemu_input_touch_event(QemuConsole *con,
>>                               InputMultiTouchType type,
>>                               Error **errp);
>> -void qemu_input_check_mode_change(void);
>>   void qemu_add_mouse_mode_change_notifier(Notifier *notify);
>>   void qemu_remove_mouse_mode_change_notifier(Notifier *notify);
>>
> 


