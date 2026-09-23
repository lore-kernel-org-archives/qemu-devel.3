Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BE7C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfc-0004Ym-Aa; Wed, 23 Sep 2026 06:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfK-0004Ve-Se
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfH-0002M5-EC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awb8gzsoKozsaUBkPHiV+I1vnke3jrFNdxglqdWV2ps=;
 b=Z0CCirFuetSNb8NmuZ4/c95W3R4u0u7lyXOzu0dzSKk73EK+FZ4jiTvviZFItBh0qYS8Vo
 44NjLnNQiRsZfGCWSUuNuNd+P3eDdEo8ctrqJlGgeyXz1050FZJ5MVk0zc7dcj6MxR/Df+
 a300T1m9dAWEI7Nshv8n15M1I9VZIeo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-qfhecfNPOmmuPEhJq-8FUQ-1; Wed,
 23 Sep 2026 06:57:11 -0400
X-MC-Unique: qfhecfNPOmmuPEhJq-8FUQ-1
X-Mimecast-MFC-AGG-ID: qfhecfNPOmmuPEhJq-8FUQ_1790161028
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEDB91800679; Wed, 23 Sep 2026 10:57:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7232541D; Wed, 23 Sep 2026 10:57:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 4/9] hw/or1k/virt: use unique QOM name
From: marcandre.lureau@redhat.com
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Bibo Mao <maobibo@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>, 
 Laurent Vivier <laurent@vivier.eu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Laurent Vivier <lvivier@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Song Gao <17746591750@163.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Stafford Horne <shorne@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
In-Reply-To: <20260922215533.641-5-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-5-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100541.1396491.9366744648871696579.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9lxijABkX9bvnNpqWEZufqqiiubFv8a2BkLdLcSZCbA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7BxKgzEYItZ4zhyZhVrQCQtzK3l856egDiRl
 +sjPt8w5FuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5X8QD/9zcGXuxjaw4bvl6C+4FSAeKogBcjsAjaT/dd5qZYjjBIzDbEiUqFb/LtfUsUasCFQAWIo
 eDQvOqcMcihnXkzRPEJ9DHEtpWU1mGzKNV7kTJj/R2ggHjAtBaZqu4O1GNUm64dUJJB9nB08Wd9
 O5m/S5OJTm9SVrKMwh882pkQ3Qfnj4UNgtFwM5mCU68Lc7g2EpJO8gmUC3c/YjQHagoXOzw/zWO
 ve7I7063SOkL/Za6yTQI4ZW4K/NKhG9Z0DkC6N+7oMUED3iNFYiCmRgN/5kuXdHa6jg1ZDSfwuJ
 hAoqKvVgMgjbVVWkwoDD3RdyPc8kqyyEN2S3/dLgFn7AYSgfvYSTXgV6d74Y/vBM/6hsUXkN/o/
 HBVjIKdhZtlXfNnG6o9cbDQ+aA8MFMeeEeuhGYODEOqmaZive8DP4oZ8z5grMC6zzewmGOl6keK
 u53LpXcMMg+uOsQk7u+SrGOUmw7OnZpBL65EQpO1GwdWTYdIJGNn7/9/cqZTlLg+gq6TfnsIecO
 wV5WQwNlBTeQ6J9UlO3ZZrZSsNeZgNin6pbZ9ZOUGhHT/rrjzcPcj2VBnurqHi66196YxpiF/JT
 uAzxUrfmxmYZHYMuuKTKuLOQggRGgGHhFMIi/EodfB5yOkf4h/OQNxfiMw8/cIt6OggNDm/T2e7
 IhV/FmXsctzt9WA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Set TYPE_VIRT_MACHINE to MACHINE_TYPE_NAME("or1k-virt") so OpenRISC
> virt no longer collides with other virt-machine types in one process.
> Keep the -M / help / migration name as virt via
> machine_class_set_name().
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Message-ID: <20260922215533.641-5-luoyonggang@gmail.com>
>
> diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
> index 2ff5c084a2b7..35884252379c 100644
> --- a/hw/or1k/virt.c
> +++ b/hw/or1k/virt.c
> @@ -34,7 +34,7 @@
>  #define VIRT_CPUS_MAX 4
>  #define VIRT_CLK_MHZ 20000000
>  
> -#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +#define TYPE_VIRT_MACHINE MACHINE_TYPE_NAME("or1k-virt")
>  #define VIRT_MACHINE(obj) \
>      OBJECT_CHECK(OR1KVirtState, (obj), TYPE_VIRT_MACHINE)

While at it, rename it to TYPE_OR1K_VIRT_MACHINE?

>  
> @@ -548,6 +548,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
>      MachineClass *mc = MACHINE_CLASS(oc);
>  
>      mc->desc = "or1k virtual machine";
> +    machine_class_set_name(mc, "virt");
>      mc->init = openrisc_virt_init;
>      mc->max_cpus = VIRT_CPUS_MAX;
>      mc->is_default = false;

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


