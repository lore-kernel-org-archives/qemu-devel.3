Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76363C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCQR-0004dP-Hu; Mon, 17 Mar 2025 11:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuCQD-0004bW-TL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuCQB-0004eI-Id
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742225429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZdZePgm4IFUyGyFCV7NyQyPTWIybVHuGloviurNVJNc=;
 b=eTkzynUMfe/iR9oLjOtpNEPL2Gf4YCIZh3gUNak3E6ZpUjq6B4uuK4yugM81Qz3BxRvZQ+
 izdENAhGAvKW93+h9Eerm5+ASu3iCsVCNRYHYWB5bMWsqTZTNMwPsH5QwXjyl009HTdV52
 Bx0x5hF609v1CQrlgtpdmfpqxe9Ak3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-kYitWjrJNkKK_et4bZXTHw-1; Mon, 17 Mar 2025 11:30:27 -0400
X-MC-Unique: kYitWjrJNkKK_et4bZXTHw-1
X-Mimecast-MFC-AGG-ID: kYitWjrJNkKK_et4bZXTHw_1742225426
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131851046so2109827f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225425; x=1742830225;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZdZePgm4IFUyGyFCV7NyQyPTWIybVHuGloviurNVJNc=;
 b=LlRcXgUutbe5E/a2J1rF3zJIHxE5mOUS/QpmwfpZgnRaXd65InJ4usYmN10vqehJ3k
 AaMkA77ZXWdL1Q6mDhTnesBv5bmmZcge0DeR1+4nqYTblg2X5qM0/lkhBxaMgpoixkdt
 750r8MCnpmmgwq135k3cTW16uHarKcIRdyon96VwHHoqNDBn6fN+m2R4N0QI+hbmo5Wf
 mDRDzBOeX5kE+6DH4y/QpcWK8cvV/7L/i5mMuvvoDqgFxMj3ehYSi4It3A5rW0qDoZ4F
 22kzVTj3Q3wvsXUmUZyS+lTJbL7qmZbIwHDsZtbsez3Rvx+hQdED/kyoH0v0ym7gwZQL
 ytKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBUv06ifHSaCcMNY0bD7HuzNqvlVuzIEQcAMK2bJmiSWANyr9NjeB7CQzSVZ7ANTjn8yxtH/2IZqC+@nongnu.org
X-Gm-Message-State: AOJu0YxjW08gucsNv7fMYwv3DtY7/IQOc5cytvg6aAq9/XmO257sTzvu
 OA0POyJ9OQOrzCt9MmjE5zi/4D/AOz4bhHXqKkaJ6iSF6BqPOZ+6TX+e3/qZMQ4ZQyifpBxwx1i
 abjoOZRAbSn6uTKrmvSBmdSAmxds42NYrmvGHB8ov2GDlOQjsx1nQ
X-Gm-Gg: ASbGncteCoWh8hgOm1uCaMDcootN2TlNzWIoBgKK/SaWEdn4USXPc9nMlQ6BnjzK73M
 70AsUS9Eg/vEVemmxfgXfGkvPZLp23HiItS4aKaPm/lyy8cGsc5pwXYgmgSb6bP4Gt+j4RU/EU8
 mK1d1Gs21eyh5CDJATwXOnbmUmkCKQwXSduMVPZBgnc15N+AVvGpUXNcd0KHQ8+ZnZh8LXfytAm
 QJoTG9uJNFfeJvfMQLDXybffBtGWWOMKI6+YC4uXt+whPavVriyILSIpGLqsTzQFJ3ULL+D1qQC
 Ii6Q03jAYYjqOg8YA25OmlL31hbmQmvkfA9Hn+00M1A9jBk=
X-Received: by 2002:a05:6000:156a:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-3971d133670mr14294819f8f.11.1742225425496; 
 Mon, 17 Mar 2025 08:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOPv3BpRN9n+KynCuxCbKKhQurOpOtsJY5Xr24Mz0TLtKzbnOjD7ERxD/EO5Jb4C7iXiIieg==
X-Received: by 2002:a05:6000:156a:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-3971d133670mr14294774f8f.11.1742225425103; 
 Mon, 17 Mar 2025 08:30:25 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb92csm15674302f8f.91.2025.03.17.08.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:30:24 -0700 (PDT)
Message-ID: <e9c80158-065f-4d38-9ca4-e11f6c05b1d8@redhat.com>
Date: Mon, 17 Mar 2025 16:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] qapi/machine: Make @dump-skeys command generic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20250310151414.11550-1-philmd@linaro.org>
 <20250310151414.11550-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250310151414.11550-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/03/2025 16.14, Philippe Mathieu-Daudé wrote:
> Reduce misc-target.json by one target specific command.
> 
> Error message is returned for machines not implementing
> TYPE_DUMP_SKEYS_INTERFACE:
> 
>    $ qemu-system-aarch64 -M virt -S -qmp stdio
>    {"QMP": {"version": {"qemu": {"micro": 50, "major": 9}}, "capabilities": ["oob"]}}
>    { "execute": "qmp_capabilities" }
>    {"return": {}}
>    { "execute": "dump-skeys", "arguments": { "filename": "/tmp/foo" }  }
>    {"error": {"class": "GenericError", "desc": "Storage keys information not available for this architecture"}}
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


