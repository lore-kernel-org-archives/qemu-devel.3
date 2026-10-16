Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1BDCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeW7-0004oa-E4; Fri, 16 Oct 2026 05:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVy-0004jD-6f
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xHeVw-0007f6-Ec
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aqn+Mz+/fva33QkNZ/gRO9EobFMyE/KYph8cQqL2mtc=;
 b=OGzk8dN4NOZ2SPDhRPKuJ/dW0mNyCWpjM4/W5DTTc33iHpmrQwjIumcuUB2P6UKk6mFfn2
 VIYmuwzzeZwAxCc6GhTeHVHiJLDD27QjdAEXFKUtxyL7kkfBBd0wZ2BwVUHoT24Tsanv7L
 Imx8aXTTcEQVnkW659woZj1E5tfRuu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-t-Bj7EItPueItfXFHzAzXQ-1; Fri,
 16 Oct 2026 09:46:10 +0000
X-MC-Unique: t-Bj7EItPueItfXFHzAzXQ-1
X-Mimecast-MFC-AGG-ID: t-Bj7EItPueItfXFHzAzXQ_1792143969
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67B1A1955F3B; Fri, 16 Oct 2026 09:46:09 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 744C81956089; Fri, 16 Oct 2026 09:46:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 11/19] hw/core/sysemu-cpu-ops: add get_note_size
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 anjo@rev.ng
In-Reply-To: <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
 <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 13:45:51 +0400
Message-Id: <179214395193.1157317.14271435744444195371.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gOKM4BkQiI+IoXNvRVIkFuKGT3VxQXpS8MeH08TpSdQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0fJSbikeM1Y1LG12fSqG7GEMuqEzlJu+J5Yjc
 Bi5Qrad3/WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatHyUgAKCRDa6OEJdZac
 5XQ1D/wJNpq876G0Kf94K08at+Lhw6ZqfLsV4ah1u7EFIVOCKN5E9DjrbrBZqdoNFnuuHOGrUgE
 VW3hPqohbmuFFdjt5xpEKjJOZ7BOvNc1BO4LnGXqlqB2xbRHpFbwp13TOj9IYkGKQWV7wad2qP8
 BsoeV67cQsNRqwemsMrpRrbu5aiR0DgBSQMvitd1YpoV+wW1sF3X6nFDS0KeGZGumozpMQ/NmS0
 O25MzqfLBPESQxONu5uyM8ReupncwTHvZqRI9pnL5rjxnBdya/8hKYI40m/UVRxlPHkQjFSyX8i
 nA9scY0ZN2ud9VQ0YB6wG9UbNsUwJAx7lxXYdFnFKjutHtW/vma4uMr5ijRuEyIzHoevOV/nNXX
 KDTmqnHaBONeS4hJLnvjKpoq78n80cxEFlYinn9QREsOdy3vbizWNwRpU/uFHwglG8pN0DXyd0K
 d6Zp9Nxze06T7u1a0Mht9jH0P5G7WlExe0u/s6O6tjKNTFSez7z31mBkzCQv3v+WCDiu0nbjN8S
 BwfHa5QFUIGBVi8PnDbj4BnA44+/kgqIkA9jpeVNsavDu9KeOKgdsrW2lhLy77cCLgXGJ/rcOxH
 TotwvqZhDRS9/7gA3XnJeOcak6R47e19a245DOJqKlS8jOyEKn40mzbm8IkbxMqWH96dSrYrWhX
 TZhWcZFXIE3wPkw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> This allows a specific cpu to report the size of the ELF notes it needs
> to dump its state, alongside get_dump_info.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Message-ID: <20261015213236.157767-12-pierrick.bouvier@oss.qualcomm.com>
>
> diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
> index 0b6bb42dc2cb..31f1674d3247 100644
> --- a/include/hw/core/sysemu-cpu-ops.h
> +++ b/include/hw/core/sysemu-cpu-ops.h
> @@ -101,6 +101,13 @@ typedef struct SysemuCPUOps {
>       */
>      int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
>                           const struct GuestPhysBlockList *guest_phys_blocks);
> +    /**
> +     * @get_note_size: returns the size of the ELF notes needed to dump
> +     * @nr_cpus cpus, for the ELF @class and @machine reported by
> +     * @get_dump_info, or -1 if this is not supported.

dump_init() asserts the result is never negative and implementation don't. Let's
have "... for the ELF @class and @machine reported by @get_dump_info. Must be
set if @get_dump_info is set."

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


