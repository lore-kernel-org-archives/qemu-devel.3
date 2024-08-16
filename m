Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F5EC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serWP-0003Uc-S0; Fri, 16 Aug 2024 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serWM-0003K2-WC
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1serWL-0005pw-ND
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723793832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LGsbGDdMqoz88zvHmCdfGsEgwZe1xcq/oIzfLEV7cnk=;
 b=dy6ZFMzjADEs/DUrnH0VXk4cAaT+UZ1aLnHlOtdUOK0ptNocFw2zRFFOQ1Fy5Nn/WXIGyY
 TxRzMoJg9OcNXiYmDNH00ORE0sLMx/oyMWBmr/L/MVijOcH+yw4FuXcqpsVlZN7LGPtlHj
 tTViroVLXJ+vQ+luXxt66Qb2t8ipDiw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295--SH15_osPumouEPYIyjsxw-1; Fri, 16 Aug 2024 03:37:11 -0400
X-MC-Unique: -SH15_osPumouEPYIyjsxw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7aa054fb2eso74501566b.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793830; x=1724398630;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LGsbGDdMqoz88zvHmCdfGsEgwZe1xcq/oIzfLEV7cnk=;
 b=d7pDrL5XzPWhM0AawDrbtTL3V82EL04kXCEehISryeVfKljEWr1oTTFD9ONnWlgJI8
 stTN5Dkuv254v1tC3IX98hpX9Xn9Hm+ttAND5b6EugMgsRh7FJzPyXiuMqyQWTUID7Wg
 mv2EjUIxRKDKW/d8KQy1J4CBd8go0dm9A1f+a5a5TfLd8rI6FMapcUZmW/T9RAAs6NUV
 AsQLTvnzn7CGFl6/84ct886BURMjwarUEGlFUDMIV2EXQ6qWX8hv64GgoPzD0pGOdisH
 ljlCbsFu8btJvBbdOivUT0tRxwtFANhhvgiQnKFOXqrRZX+oZ1uIDXAKkn0Ao1nHgQ/z
 t7nw==
X-Gm-Message-State: AOJu0Yz1ByvzQC/mo9o7k1jgxKFtOR6yppj7/MVVoFE4GQjp2oZJzgS5
 vWJYHG6+C0CGoA8fcIyXokPJB5aJGcDBw+S+kbzPbmnOSipoBMpeSrhQnJKenJW9oxkVspZZi8T
 w93xF0Dt7bi4ctDwIjzT63qYK1YFekYgcK5W0hTlhCJctdprozl9L
X-Received: by 2002:a05:6402:348f:b0:5af:758a:693b with SMTP id
 4fb4d7f45d1cf-5beca4d7c45mr1506508a12.4.1723793829823; 
 Fri, 16 Aug 2024 00:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELOscBkSdLWAw1HIKMjdtVXW+qt04BPOg7q/2ndhhAnXKJ3w3cvLGo/G4CpIgGHuPa5Aa7/w==
X-Received: by 2002:a05:6402:348f:b0:5af:758a:693b with SMTP id
 4fb4d7f45d1cf-5beca4d7c45mr1506476a12.4.1723793829240; 
 Fri, 16 Aug 2024 00:37:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17d:3378:6322:e9ee:713:b9ed])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbbe29a6sm1875305a12.13.2024.08.16.00.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:37:08 -0700 (PDT)
Date: Fri, 16 Aug 2024 03:37:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.1? v2] hw/pci/pci-hmp-cmds: Avoid displaying bogus
 size in 'info pci'
Message-ID: <20240816033654-mutt-send-email-mst@kernel.org>
References: <20240801131449.51328-1-philmd@linaro.org>
 <8e386637-3481-4eaa-b19f-70187924d817@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e386637-3481-4eaa-b19f-70187924d817@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 16, 2024 at 08:16:15AM +0200, Philippe Mathieu-Daudé wrote:
> ping

tagged this now, thanks!


