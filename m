Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596BFE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 17:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTP1K-0005SU-MI; Thu, 02 Jan 2025 12:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTP18-0005Ok-Ow
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTP16-0007Cv-IQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735838985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVY//sOu7TD2ARNP1idQFN/vhkwE03DWWg48Mpq2REk=;
 b=T1CNiJMnbuU7n8M03oCKbjeUhZutQHU7W2JD0KkOhv5a1afhTsh2QXedd7/1fh4euTlnwf
 yR5kku65A9GyX46nol6d4+M1ODfl5CudJy6NxSOpJVulWSYFoYJmTN8MJ8SyofDgdTkPxz
 sFx0MN+DWEuw3rtOnJwtc/9AJkKg8Is=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-QWWrYTTLOxilcuiwaW01Hg-1; Thu, 02 Jan 2025 12:29:41 -0500
X-MC-Unique: QWWrYTTLOxilcuiwaW01Hg-1
X-Mimecast-MFC-AGG-ID: QWWrYTTLOxilcuiwaW01Hg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e23e2b8fso1078889285a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 09:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735838981; x=1736443781;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVY//sOu7TD2ARNP1idQFN/vhkwE03DWWg48Mpq2REk=;
 b=JYhZnEkGRxORFWtVH9co/F+mgWpB4/PKmgem/PuFGk1zLGClPyMU4fSRNo/cPU5CxG
 XaewNHhjH/6dG8VZoYNuhwEZBGPjb7yCgXhqYhebUPYvUBMjVXdLH/Wykl47T+Dk3UaT
 Y9cCNp1EoJmm/ETOMIMY6FwfgSlVX2K/aIclRNULv25LSy11YC9NtVVtMJBiaaNyNr5d
 bJ8/1jrEOHKnSnnjoolN3XxrVm2llHKjurqVU+wQc+X0m3CkEL0HcBiZrIsg8xasO+gj
 K/NzHsXlHVzxni/dJAoNZc1OBVihSYnPPmf+4yxUBG6xL3pZOH7MkD7xI04aJWm4WpMU
 afAw==
X-Gm-Message-State: AOJu0YyW/Fso2FBi5Y6iiGI/h7h1s5sLisky9Uue7rp2lynE58yLTtrD
 r+jIQRq0VOHX7QNG9fU/FUNdPJDFhlVCS+JXvlkY+U3u+kMzxdlrlVI8mmcRGnmw9k2nZhS70HQ
 FHjNeCF1clAIGk7kLqGawudY0yz4UTlZ46QTgfdUhnYBUaH45l5Lh
X-Gm-Gg: ASbGnctwK6dYdK4Oe6qGmx62pEi8PHzWJuItn2HROmrfHe8wphdJEQ6+lt20419erz3
 7eoaL8lhRuR6hZIWE9iqTRTe3DtHI/+maUs69XNX8xOLCUn8xZcILs9vwG/8qfHzL5eq/hKKoJ0
 RqkPymdGwiGmrnfLTISH/CCap/XOylw4eusMD71MGg5u2TsRHvcWJa2+GbbS9seNuX8aQva5z+h
 ha9Q/YkY0isK66P1RPVxBjh8XDmtZrjtgwXarI22U6/K0FqwpeYkpXZpatBq06+4flEu3p26bag
 2XFsUWfDesV30IjknA==
X-Received: by 2002:a05:620a:2492:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7b9ba6efae9mr6866555185a.2.1735838980794; 
 Thu, 02 Jan 2025 09:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqYbxVXVWBPeMLQaoTvUQRJxLDJYecTU73qUIlcuIBLrOEOwrhlAv9V+EfsNs5WXIm2FDkDA==
X-Received: by 2002:a05:620a:2492:b0:7b6:e697:2090 with SMTP id
 af79cd13be357-7b9ba6efae9mr6866551085a.2.1735838980410; 
 Thu, 02 Jan 2025 09:29:40 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30d7e2sm1202693785a.59.2025.01.02.09.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 09:29:39 -0800 (PST)
Date: Thu, 2 Jan 2025 12:29:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v3 00/10] QOM: container_get() removal
Message-ID: <Z3bNAUORnY7QHxYY@x1n>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 02, 2025 at 04:12:34PM +0100, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>   qdev: Expose qemu_create_machine()
>   qdev: Implement qemu_create_machine() for user emulation
>   qdev: Call qemu_create_machine() on user emulation
>   qdev: Inline machine_containers[] in qemu_create_machine_containers()

For these four, all look fine to me, feel free to take:

Acked-by: Peter Xu <peterx@redhat.com>

Said that, still one comment: maybe we don't need to make the function
qemu_create_machine() to be an user+system API?  Instead we could have
user_ss defines qemu_create_fake_machine() and invoke it iff USER_ONLY, the
same as what patch 3 does.  Then we can drop patch 1, because exporting
system's qemu_create_machine() isn't required, IIUC.

We could add some comment above USER_ONLY's qemu_create_[fake_]machine() on
why the fake machine is created (qdev_realize() of cpu devices relies on
machine object, etc.).  It might still be helpful hint so that we know it
can be dropped if qdev_realize() doesn't need to rely on machine one day.

Thanks,

-- 
Peter Xu


