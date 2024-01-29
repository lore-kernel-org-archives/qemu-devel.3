Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F8C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUYD8-000584-It; Mon, 29 Jan 2024 15:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUYD4-00057k-RG
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUYD2-0000TH-5s
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 15:26:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706559983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8wfH9WJ2SufXEVzuXR5nICU+TxvvQdTuY/dQcfgBHY=;
 b=Xvk7TXPtN4vl27s/RGNB+5PMMNWpi1WhlKp4bERyF/scQ78CMhJwnoTASn3pRcF+HCPz1c
 IdPpUHxaj3CczdRDhSSKkF9c0mm0zh82cL0Z82QdjxR1iuzvZla0BvKNDIBvWzpTJslC2G
 kXwcbGseLYniXaZeE9cL+Kz5PjtZl8M=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-lNNuaTlNMN61hOMKVTSwdw-1; Mon, 29 Jan 2024 15:26:21 -0500
X-MC-Unique: lNNuaTlNMN61hOMKVTSwdw-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-46b33bc35fbso676498137.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 12:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706559980; x=1707164780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8wfH9WJ2SufXEVzuXR5nICU+TxvvQdTuY/dQcfgBHY=;
 b=p03xY45fBuX3F0G2uarHdaJUJ2kOHFT+Q5yvb3FYvf93YbeZ4LelAN6wTSXhXr7b1s
 NaqELGP5iAIgpOLJuWFC03ujnReXQvmnrRS5FEZBiAMIvWGTZQQ38CfT4gGDln2/z+5B
 rtrGelozFebJplgUWF0rejukruTJG/xmGGV3sYN7yEEgc2Al17Q/9ZHQJwCc5j36+tcW
 89KMqK2yX7GQYqeiN+zp7XAIBf1VU0WKsvXGOBW4qAP+UxrptiG1qbNAXphWanGHEv53
 JsZD3HMVIp9U2UdezX33WEG7AOz9PGaa7lJp7pvU124UwCMDzPtrtOm0B/EAdvH4feGu
 CphQ==
X-Gm-Message-State: AOJu0YzIF9opEYoZXH98ouiIvY37dKXRFPh1LJYZnlp5JMQtXAflt17b
 0VjX17+fxU8oosxYg2rsJIW6ou4/H/HJtEZkh+GfcykDOQfe52yoxuT16RXEa95WAmd18qDOb7h
 Nyd8hJUll8ATYBYP8d1/34AofPwztdHMa7gmRP1AXhhARQQDzelHMHPnL6duVAc7l6mD40iCTZs
 d8rrCSBMYPYkt+ACAgILrAlfzLjNA=
X-Received: by 2002:a05:6102:41a0:b0:467:fb8c:6ee5 with SMTP id
 cd32-20020a05610241a000b00467fb8c6ee5mr3330948vsb.49.1706559980790; 
 Mon, 29 Jan 2024 12:26:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGM74nyv7RpmtyUBGQ6dhogwrMkqKDO1qiF5hi2E4WMNIeixCbB5Zpg2Ba3advItzY4exI4AzJs8VTymHyRItQ=
X-Received: by 2002:a05:6102:41a0:b0:467:fb8c:6ee5 with SMTP id
 cd32-20020a05610241a000b00467fb8c6ee5mr3330945vsb.49.1706559980561; Mon, 29
 Jan 2024 12:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20240129133751.1106716-1-pbonzini@redhat.com>
 <20240129133751.1106716-3-pbonzini@redhat.com>
 <AE14AC8A-AA67-4F69-8D45-640C93217935@gmail.com>
In-Reply-To: <AE14AC8A-AA67-4F69-8D45-640C93217935@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 21:26:09 +0100
Message-ID: <CABgObfYe8DNifSra_42L06bJ_ACuoTZ_yxNjUUkyuqROypiZNA@mail.gmail.com>
Subject: Re: [PATCH 2/4] isa: extract FDC37M81X to a separate file
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 29, 2024 at 8:49=E2=80=AFPM Bernhard Beschow <shentey@gmail.com=
> wrote:
> Don't we prefer a macro for below code? While touching the code we could =
use it. (Sorry I can't recall its name from the top of my head and I don't =
have access to the code right now).

Ah yeah, OBJECT_DEFINE_TYPE. Not sure it's much of a win because
neither finalize or instance_init are required here.

Paolo


