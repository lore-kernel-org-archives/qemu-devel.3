Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90924C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 11:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmB1b-0004W9-4j; Mon, 18 Mar 2024 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rmB1W-0004Qc-7Y
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:19:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rmB1T-0004Hj-JJ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 07:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710760757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cos00PGSs0Ra6q8T+SiUzy2TYJ6b+6K8ELi5YCQ3iKA=;
 b=IGqb2iVEO3P9ZhzMQJhfiABPxWZTHs7d8GxAegMARthq6e5J8UHmT6tGTnbOaXXHrw4EQs
 5fw6iAdtX6hduLf6HkaJZdCA/pwCke9wPz57nuTHr9nwnpGumNjV8kqSjGFIyW84v9hD9S
 SXWSr7gXUzhjCeIerXIAJdsURAp/pOs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-vhLaH_vAOD2j9kIaH9r_IQ-1; Mon, 18 Mar 2024 07:19:15 -0400
X-MC-Unique: vhLaH_vAOD2j9kIaH9r_IQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed2f873b4so1565986f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 04:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710760754; x=1711365554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cos00PGSs0Ra6q8T+SiUzy2TYJ6b+6K8ELi5YCQ3iKA=;
 b=YVOBNm8XGzYGxhiVvdiL9yeICJKsjlolC/s3Zi6CA0NefqeqVeF6tOaDHkh13aguEd
 yA4bWziADjQdJKJzR1gob2a1jPkj5NzPgHvxXWR4mOpBlUhIJ4W4slh5kjsXjoqE34pg
 msU9o/ij9qpF+3mejDbS2BZ7u0nsoZGrVv2FoVXgsBj+PX7+PMmeL09kdh3dBkk6EP91
 sh8yQdqtsSYPnlN3J+6zQkp6qAszh4/Wvpk+1QnrFdT68wJ8bU9trhGeOrTQbnQSC6AZ
 qDJi7y1hhvECwYJeXxQhomWmbfDUCEcpDOeYRJdOnf5qBzP2jMAA93LMDcFxzYjlEZSO
 XSgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgSY1P0Cf3CFIBw/R57xK65lzkwZaNU/PXpUHKaP656CuaSWq+455ZivV8WABuxh709p8isRumuGQMol/dn+imYH9Z/3s=
X-Gm-Message-State: AOJu0Yzm6XkiS7Xczvps2tofZejo1VQ5qcVD7PSNl9VxBMQJp6YE/pcv
 G7e8nL0bX/JWCZC1KMO5Jex2zH7tMp9XhkYJ7878n2ZgBzPLbHXKQa+mxQIqQCUGnf9Ha5OOBk1
 cDiS5oreoG/RzKDZbc3hUhYqsZ/F3+cjBVZpXdi1QmxdXdxTGCnJiLa7H2N0f6lzpZAq2N8m/AG
 CNSQRYfkpq3nY4rE6S7WpggANEmcY=
X-Received: by 2002:a5d:5a0e:0:b0:33e:76db:9bf8 with SMTP id
 bq14-20020a5d5a0e000000b0033e76db9bf8mr10374147wrb.68.1710760754780; 
 Mon, 18 Mar 2024 04:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmWW5efbFJfMQx/oE1L4+88UaI5/Je/vcTyHm3syjL56BBpgmzL7c/n5PKdN0MT4RSoKdycQkvQa/ulhMcYU=
X-Received: by 2002:a5d:5a0e:0:b0:33e:76db:9bf8 with SMTP id
 bq14-20020a5d5a0e000000b0033e76db9bf8mr10374129wrb.68.1710760754461; Mon, 18
 Mar 2024 04:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
 <Zesv4W8DKteGeE/a@intel.com>
 <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
 <Ze6UmDoFD5Qd8AC/@intel.com>
 <CAE8KmOzwrLY5ag_FKvX-ovAopfPeYSqFHc3-sdQj_zt_28tH5A@mail.gmail.com>
 <Zff2DgJa+eHPBhgJ@intel.com>
In-Reply-To: <Zff2DgJa+eHPBhgJ@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 18 Mar 2024 16:48:58 +0530
Message-ID: <CAE8KmOyLFfOg7vtrHnrPxS5eaiHq3=9XdZ4qwrNsmJz+zhWdfQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

On Mon, 18 Mar 2024 at 13:23, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> Indeed, as you say, these items are initialized to 0 by default.
>
> I think, however, that the initialization is so far away from where the
> smp is currently parsed that one can't easily confirm it (thanks for
> your confirmation!).
>
> From a code readability view, the fact that we're explicitly
> initializing to 0 again here brings little overhead, but makes the code
> more readable as well as easier to maintain. I think the small redundancy
> here is worth it.
>
> Also, in other use cases people always relies on fields marked by has_*,
> and there is no (or less?) precedent for direct access to places where
> has_* is not set. I understand that this is also a habit, i.e., fields
> with a has_* of False by default are unreliable and avoid going directly
> to them.

* Ummn...okay. (I'm not fully convinced, but that's fine, I'm okay to
go with you on this.)

Thank you.
---
  - Prasad


