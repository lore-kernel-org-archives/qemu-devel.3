Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F3C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMRId-0003Yw-4w; Tue, 03 Jun 2025 09:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMRIa-0003YK-KH
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMRIU-00041n-LF
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 09:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748955794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MszUiDrpWYeW0q2I8W5Zv2NVZ/5FIMqJ/KcsFt/wWDs=;
 b=Er6YMYUkaya7iutpDORI7MWTHOnFrpUn18cc6zOrPXWfREdKZgGsa9zXKwLpvLAggPKuRh
 vKr+V3uODkNPdOJb0CkzFug9CF9bR94V/cghB4MG566fmj2x8V9CkvOQIsyilVNolwXKi8
 0Al4u0bT8z+6tVd1rO4F2ToMSeTf/2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-aBTwua9JPx23qJh-JqDW5w-1; Tue, 03 Jun 2025 09:03:12 -0400
X-MC-Unique: aBTwua9JPx23qJh-JqDW5w-1
X-Mimecast-MFC-AGG-ID: aBTwua9JPx23qJh-JqDW5w_1748955792
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso30071645e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 06:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748955791; x=1749560591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MszUiDrpWYeW0q2I8W5Zv2NVZ/5FIMqJ/KcsFt/wWDs=;
 b=xDt9IP4Nl9MRQMEUUUkSoAchXl3ECSthwJQxi0b6RyD6Q6tbWqvypQJ8JeNiiyGBjr
 fiyRZGLpqdHpxQiXsNOZDIOuSJBMVkpnCU03NZMtds7mTGUWa5J1zDGqZlTfU6cFXxUF
 NJ6l76hOPhx3OvPWjX4XNsVCJ+XXjiI38+8OTlBCGJZw6Ux1WAUgk4BflkrzXchHADlr
 DoN9bj4mjjwr2umCBwj9NMLBMAO7bYOWWviJLh6YF3pME4kJycknwszkZzrXFyL2WgkP
 TVmuJCzwdgkPIVjhoHpG4nzo9mZgfmvyg7zZAwxY95bQcBBueX/AagOjhSms6kmc66S5
 K/4g==
X-Gm-Message-State: AOJu0YwnA2Wa7VLF7sjNWh6cjy9O5St08wK9cRgy3A5AtQXpB/tpU999
 qoyr2ii8pyobYzoN+ACiDH1U21e7+Tv7/n0W3Jbnr2qBBFRQ3vu5g4kBsjubRX0wyjYsQ/W1CvS
 VuHX0wz5z27U53qzO3Ok5aeDP8lwFdUXaslbPvLT45Wm8IETBwOWrMteE
X-Gm-Gg: ASbGncv/RseN4ddc6EXeiGK3qa60wKoai2+Wh3/0QYxMNQ5Z1YfXICuTEPVE+fdxebW
 os1IUOoEK/Y/X6TXSXnrwhbY72wtXx8nevk1Zw6On6BcS9W1GmADgLpUoY3uCLoNIhZEAnZkFUZ
 4zPikrl82PQld2KQRkoh2GFj0X0XiofM18MlniRXmTbt0ZfoQ0DpX3QvHRhZ9aZehfRXNtNx4x4
 SijerPkAySKK614eh2MObE9NJgvdLbTDFVxzllag/KE3WJ0d//jtSN6pYZJScGZWDZjRDKtfCnG
 d9Qt12lT1+LtfbvZfGDx66g0DOgPdK2Q
X-Received: by 2002:a05:600c:1d03:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-451e65b2ef2mr26035215e9.10.1748955791165; 
 Tue, 03 Jun 2025 06:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcWEzMm7vN92PUh+yYsubNU1JAiTOWmNcK7BB0Pb+F3uGmYyFaGrN/5FgPHDKmHsR6QyDwVA==
X-Received: by 2002:a05:600c:1d03:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-451e65b2ef2mr26034585e9.10.1748955790632; 
 Tue, 03 Jun 2025 06:03:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8000d45sm161168675e9.25.2025.06.03.06.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 06:03:10 -0700 (PDT)
Date: Tue, 3 Jun 2025 15:03:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
Subject: Re: [PATCH 12/13] microvm: enable suspend
Message-ID: <20250603150308.5d4ef10b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250528164203.2239-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528164203.2239-1-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 28 May 2025 12:42:03 -0400
Annie Li <annie.li@oracle.com> wrote:

> The function qemu_wakeup_suspend_enabled combines the suspend
> and wakeup together. However, the microvm doesn't support
> wakeup yet. Suspend is enabled here, but wakeup doesn't
> actually work for microvm now.

why wakeup doesn't work?

> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/i386/microvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index eba33c4365..da5d4126e5 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -489,6 +489,7 @@ static void microvm_machine_state_init(MachineState *machine)
>      qemu_add_machine_init_done_notifier(&mms->machine_done);
>      mms->powerdown_req.notify = microvm_powerdown_req;
>      qemu_register_powerdown_notifier(&mms->powerdown_req);
> +    qemu_register_wakeup_support();
>  
>      microvm_memory_init(mms);
>  


