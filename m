Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EB8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Dy5-0001gL-TJ; Wed, 15 May 2024 08:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Dy4-0001fz-9a
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:42:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s7Dy2-0006MQ-IT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715776965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJNW1SF4f0bmWa4PeALvFSZoRgy4MQPa7fdx+Uuw7yo=;
 b=B1S/ULH83ipofFPD7wEfMNm4kotgERVjgHxt4s4JmCD8o6Rcxe6Q+bjqz2S1J/6zw2HepE
 mXbdJ8L6Vkbkwxcpg/PO4WobrDWlc5BK6uXjcpWqx/5hWCJLXKduxs3zpG6QcSHSl2uHPM
 oCUGAjQg4U1BTz1cH5/no1dJCZjXgGY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ATJKmQtQMjW03TSQW56gZQ-1; Wed, 15 May 2024 08:42:44 -0400
X-MC-Unique: ATJKmQtQMjW03TSQW56gZQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792cefecd00so884017785a.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776964; x=1716381764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JJNW1SF4f0bmWa4PeALvFSZoRgy4MQPa7fdx+Uuw7yo=;
 b=REQrUnowP7ucWBGfZcVKJD0lGvSCaskuBZVhm4h1lhlL7nDaCz8HARX+AZNFtGNVUV
 ziA7BQDhabWxXykOCHz+8zBG2kdkFuhVNaxK2ksqaecMUKZlb3afgCW08vb3HZtFPyay
 06hT3ZWvUh3w6fhXwXLblHwM/eYC0gYbu6s6Xr9BDWN53GVqKHeSDoHkhjmDAOJ6m0Ca
 iLqDeS2uAmYD1Bmv0l4ucAZjkOBF0kWtUbeNa16/GW7/Pz4yl6JeS/adydddCnvoLZf4
 +d65BenYJML9LFUTJoq+6xJyl69T0h3KPVnlNK1MYlju0csBJUGptNP2Ra+w6X7O9BVQ
 Ym+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTjzMtx32KF3oWnnMuEUc514mp/MZTUve4ZSSh/7I82nwnn5qTBd2mVfIlcyk+loZ/N6WXicrL7j4EMO5JX5kXR+Zs9eo=
X-Gm-Message-State: AOJu0YxVFVnNEsrMuASb6TxGJtbxkINNtQsEs2P9heLjLjQ7wMRx6Ikr
 qZwIA3OM71CFXxfO1+w+Y+scXYNp/amasC/Da5dKhOYV5sSdzilBzMR6hoAGkkw53LU8SD9g4B3
 zpJM1+dLQqHgGUhkMZYgxFy/MsIxce+ELwjV9dyGMH7R4bzvtSLX6
X-Received: by 2002:a05:620a:5705:b0:792:ff9a:1834 with SMTP id
 af79cd13be357-792ff9a1a2emr67592785a.28.1715776963777; 
 Wed, 15 May 2024 05:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Y/2U23QFhH6wh0k4lIOIXIKL2J114AypB+Je5n9r0TfZx3XQqUfvdyPeHBdGfA9kT1rvFA==
X-Received: by 2002:a05:620a:5705:b0:792:ff9a:1834 with SMTP id
 af79cd13be357-792ff9a1a2emr67589885a.28.1715776963460; 
 Wed, 15 May 2024 05:42:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc55csm675630485a.85.2024.05.15.05.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:42:42 -0700 (PDT)
Message-ID: <678f0a75-fc4a-4553-8e6f-4dd970db89e8@redhat.com>
Date: Wed, 15 May 2024 14:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/11] ui/console: Use qemu_dmabuf_get_..() helpers instead
To: Richard Henderson <richard.henderson@linaro.org>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
 <20240514131725.931234-6-marcandre.lureau@redhat.com>
 <0a86ac2c-3635-4bb8-b86e-5fbf93676751@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <0a86ac2c-3635-4bb8-b86e-5fbf93676751@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/15/24 14:38, Richard Henderson wrote:
> On 5/14/24 15:17, marcandre.lureau@redhat.com wrote:
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -70,6 +70,7 @@ void gd_egl_draw(VirtualConsole *vc)
>>       QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>>   #endif
>>       int ww, wh, ws;
>> +    int fence_fd;
>>       if (!vc->gfx.gls) {
>>           return;
>> @@ -83,7 +84,7 @@ void gd_egl_draw(VirtualConsole *vc)
>>       if (vc->gfx.scanout_mode) {
>>   #ifdef CONFIG_GBM
>>           if (dmabuf) {
>> -            if (!dmabuf->draw_submitted) {
>> +            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
>>                   return;
>>               } else {
>>                   dmabuf->draw_submitted = false;
>> @@ -99,8 +100,9 @@ void gd_egl_draw(VirtualConsole *vc)
>>   #ifdef CONFIG_GBM
>>           if (dmabuf) {
>>               egl_dmabuf_create_fence(dmabuf);
>> -            if (dmabuf->fence_fd >= 0) {
>> -                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
>> +            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>> +            if (fence_fd >= 0) {
>> +                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
>>                   return;
>>               }
>>               graphic_hw_gl_block(vc->gfx.dcl.con, false);
> 
> If !CONFIG_GBM, this causes
> 
> ../src/ui/gtk-egl.c: In function ‘gd_egl_draw’:
> ../src/ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
>     73 |     int fence_fd;
>        |         ^~~~~~~~
> cc1: all warnings being treated as errors

I sent :

https://lore.kernel.org/qemu-devel/20240515100520.574383-1-clg@redhat.com/
  
> There is no reason to have the declaration at the top, rather than here in this block.

It could be done that way too but since we need dmabuf, it might
as well be declared at the top.

Thanks,

C.


