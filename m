Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OFoOc2vY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FfQ4lX23
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJo0q-0003PO-4f; Thu, 22 Oct 2026 04:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJo0m-0003Om-6Q
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 04:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1xJo0k-0007IT-KE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 04:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792657133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vROFaBvfmuhO0KhXXpIkjsbXhJ3UWCW6RKCNHGV13k=;
 b=OFoOc2vY+EGBX7tWtQuJts4p8Y7lm40eQHLP5+e/6WtgkLUfwBkboZD1mykd1WJybXY5pL
 F4lQdkLSwJ3hg+v1UmUKtQwBgvl34zJDoWaPwBVf5KwGaYiOVl1MlKT0usluTeKaqVmQkE
 i0Kojtunqd6ce/0u+A3lZALg0MF9mzw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-B83bxrsIP9ahJ_ZVzIhOJQ-1; Thu, 22 Oct 2026 08:18:48 +0000
X-MC-Unique: B83bxrsIP9ahJ_ZVzIhOJQ-1
X-Mimecast-MFC-AGG-ID: B83bxrsIP9ahJ_ZVzIhOJQ_1792657127
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48df730c035so1156339f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792657127; x=1793261927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6vROFaBvfmuhO0KhXXpIkjsbXhJ3UWCW6RKCNHGV13k=;
 b=FfQ4lX23zZ0egPOiauA1dm6KBQic10f1Ed/CwOyerFz02DS3fVaLoK8tqmMPhhcznR
 /8dlKEqwBK8+ZYU3tU7WUVgBtWHhDxi9YrfX2FURPchirLnWgIDdwmp6Wf7mhR4hCHMk
 yYOFnNNyl89WYSQzakvigB15CTYs0+atCpGInzFoMZHnh8+pquFf0mmy6ow245R0nMiT
 E3pb+sNVty99uks/4a01yFF3mUfU4Kl4AyLu3Poph6/Z8fuChmbppjw4DActjoNhr2U0
 V+B5LkHGy6+w7FZC0XFpxOavAOt1OmUGz1+0FCMuquZfwNvS1xIYbXzckS8nbj6abBo+
 PEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657127; x=1793261927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6vROFaBvfmuhO0KhXXpIkjsbXhJ3UWCW6RKCNHGV13k=;
 b=cEtbgi6iO+3zx9UkWnDRr5Bsyg2QWpPrOFLIqgYwGLKMneY55Iyes/nmcmPLK0b0L7
 /XyOBlVcBxgsQr1gHEPirF6i+W++gTOPtcdkqKzGZwO5gZmd8xEla9MiYmnTXsAbYcof
 BtUtLEtZLPv/5rZgDoOIooJnc4JhsRlmLZDEO27t4Apds5dtDaSmaQoIdKMxB0wBB4Ld
 oZh4aHpMtdhdajrcfPDjxP2lMIq5Z8Hm5rLgJK/kd7E/7fxgacRF2e7MmuAa3tBm3rlR
 hyvkyFR7A5DJLPojN4RS6qyCIVepw8cPBUF/jbZ5bczOtjWV3TkTYQZL1LthNmpID8Pg
 6nyA==
X-Gm-Message-State: AFq9FYIdq1qRuFNVkKYaIMP5NpmNPTYR8CcwNLIXSYhzhxXdFXbjAD4e
 notVUAsng9v9wK2sP7sWTbGhBxNSOxp82pRYAsejdQyOTvbA288KIHkcb4M+B5Y9PK7yRu1A6di
 C7tAhEKEL4Dmr0hra/iA3xmjZoBP+zPdw3NCWgfnbvr1S6oa3i6kRTMYX
X-Gm-Gg: AYBFou3mLZal/KtQ9fPRef6pNgyE1FjMo/TZbIIkIgOKWOmkX1qgh4RfBuBRcCiuvMC
 zDJO8krRsVNsKq40ajA84dmKbG0owbj2uJ/NK68emY6ZyxwwodH3aXHW0979zqOnhx4U0cCqunk
 Ric4WskD3IVWgyLh+pJW8VM0cM0cRlxqQtCaiPfwVPRVtdkp7d1jrYg9TM0g6+sv/erPG5d4jow
 NethqoPpOufsknYFOU5GIWtCNWxCWGX+Ik2v/vQmJNEllyUg/adBwwXtKiz4dev6K+6Zx7Wges+
 j9LNP4sVktfjsDB5wm+KBsYSbkdqSsYKViU9yt+JFq3MXFU+7voFIqIgMCs=
X-Received: by 2002:adf:f392:0:b0:48d:f391:5c45 with SMTP id
 ffacd0b85a97d-48e264dd0c0mr6463363f8f.42.1792657127432; 
 Thu, 22 Oct 2026 01:18:47 -0700 (PDT)
X-Received: by 2002:adf:f392:0:b0:48d:f391:5c45 with SMTP id
 ffacd0b85a97d-48e264dd0c0mr6463342f8f.42.1792657127077; 
 Thu, 22 Oct 2026 01:18:47 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254f02f1sm11956396f8f.3.2026.10.22.01.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:18:46 -0700 (PDT)
Date: Thu, 22 Oct 2026 10:18:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: pillow <waysorrypub@gmail.com>
Cc: qemu-devel@nongnu.org, 17746591750@163.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, jiaxun.yang@flygoat.com, mst@redhat.com,
 anisinha@redhat.com
Subject: Re: [PATCH v4 2/4] hw/loongarch/virt-acpi-build: Drop UART _DSD
 clock and add _STA
Message-ID: <20261022101845.381dd1a6@imammedo>
In-Reply-To: <20261022072238.319308-3-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
 <20261022072238.319308-3-waysorrypub@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 15:22:36 +0800
pillow <waysorrypub@gmail.com> wrote:

...
> @@ -325,7 +324,7 @@ static void build_uart_device_aml(Aml *table, int index)
...
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0x0f)));

also is it really necessary? Doesn't missing _STA imply 0xF already?

>      crs = aml_resource_template();
>      aml_append(crs,
>          aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,


