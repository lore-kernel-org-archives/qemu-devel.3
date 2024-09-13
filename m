Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021C2FA3728
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 08:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp1GN-00043N-0e; Fri, 13 Sep 2024 04:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1GK-00042o-B0
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:02:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sp1GH-0004BO-RL
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 04:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726214555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9BIS6N0Uk11OZFMlp3v1v7NHUWdnxsavDPt7VIlwXPQ=;
 b=Dz9SzosZmbKddv54QjHScTlKkJWh8KmXi2UMQaQwxYIdMMphMmxffTEnPq0E4PiRFVdU7R
 fwK+df6oA9YqK2zBdzSn0tVc1O4pJlatw5pRyc3AtIJOvBtc5eGbh/ULdYDdq4W+3ON56m
 9LnMoVdB84Tj5ynhIr3FvU7dGFbbUxM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-FjPA4v5XMuWqbCfUijlKtg-1; Fri,
 13 Sep 2024 04:02:32 -0400
X-MC-Unique: FjPA4v5XMuWqbCfUijlKtg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1794719560B7; Fri, 13 Sep 2024 08:02:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B11C619560AA; Fri, 13 Sep 2024 08:02:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EEAE21E6A28; Fri, 13 Sep 2024 10:02:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Bibo Mao <maobibo@loongson.cn>,  Song Gao <gaosong@loongson.cn>,  Peter
 Xu <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v4 1/5] hw/loongarch: Rename LOONGARCH_MACHINE with
 LOONGARCH_VIRT_MACHINE
In-Reply-To: <2f7acdd5-9d9d-442c-a19f-c8a5828ae02b@redhat.com> (Thomas Huth's
 message of "Fri, 13 Sep 2024 09:36:42 +0200")
References: <20240508031110.2507477-1-maobibo@loongson.cn>
 <20240508031110.2507477-2-maobibo@loongson.cn>
 <2f7acdd5-9d9d-442c-a19f-c8a5828ae02b@redhat.com>
Date: Fri, 13 Sep 2024 10:02:25 +0200
Message-ID: <87jzfg2d7y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/05/2024 05.11, Bibo Mao wrote:
>> On LoongArch system, there is only virt machine type now, name
>> LOONGARCH_MACHINE is confused, rename it with LOONGARCH_VIRT_MACHINE.
>> Machine name about Other real hw boards can be added in future.
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
> ...
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index c0999878df..6619cb52a9 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
> ...
>> @@ -1208,7 +1208,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>>       MachineClass *mc = MACHINE_CLASS(oc);
>>       HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>   -    mc->desc = "Loongson-3A5000 LS7A1000 machine";
>>       mc->init = loongarch_init;
>>       mc->default_ram_size = 1 * GiB;
>>       mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
>
>  Hi!
>
> I noticed that the machine now does not have any description anymore, which is kind of ugly when you list the available machines:
>
> $ ./qemu-system-loongarch64 -M help
> Supported machines are:
> none                 empty machine
> virt                 (null) (default)
>
> Could you please come up with a new mc->desc for the virt machine?

Formatting a null pointer with %s is actually a crash bug on some
systems.


