Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD2EC98307
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Kfi-0004dC-Op; Wed, 23 Sep 2026 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfW-0004Xt-4C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9KfO-0002Sf-Nu
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790161054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxicqioWmuQg+baYszlp6jsKoKgPYZCrMhZcR0Bx8+E=;
 b=JTI6CMRsyAZhjHzWuvNAfDB9YvEfAycWA7V42X/l7GQH2qSgjiK62IXAJf/0fY2hK4KEbG
 gajThk3gqkRZqsKMDGcieR4L9tuicBv8vRW1biHamVklYFqdWFXEKm3/MJeIOsBqQfmVXB
 7JcUTXWKekHGHW2Y0kwrnPkipS7kDNg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-AML_iXOlOo24fa8RcNvzMA-1; Wed,
 23 Sep 2026 06:57:29 -0400
X-MC-Unique: AML_iXOlOo24fa8RcNvzMA-1
X-Mimecast-MFC-AGG-ID: AML_iXOlOo24fa8RcNvzMA_1790161046
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8689B1944DDB; Wed, 23 Sep 2026 10:57:26 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3CFE1956042; Wed, 23 Sep 2026 10:57:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 9/9] qapi: return MachineInfo typename from
 query-machines
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
In-Reply-To: <20260922215533.641-10-luoyonggang@gmail.com>
References: <20260922215533.641-1-luoyonggang@gmail.com>
 <20260922215533.641-10-luoyonggang@gmail.com>
Date: Wed, 23 Sep 2026 14:56:45 +0400
Message-Id: <179016100553.1396491.8874451102810485078.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=596;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=QQpPdMVl0ZoxtZTqY6VPFLAsJs28xRpi3eIBdEeke70=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqs7Bx7dELfa1iV+ZEG2mGA9YHlK1g8Hx3M2Yod
 GiFrMqmCV2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarOwcQAKCRDa6OEJdZac
 5ZbVD/wLO4qMwJ/0x8f7ytLn+MndrUxZ/HeI6qLQ+dnzNPBCx9evr4WOSyqNAOLvLovzoRS8oGR
 8v5RbbPCUBimLmcGXa1Llyb0uo/FLheDl+OhPn8XVLuBioq9tDRCeY1fRtWy/NZMcru6cLifJFK
 9WwOGbdmbxYTnR7D1/irbMIf7bExet1sbQ8WdgkbWTUA0yOp1Qiz+1G3Qca7c7wXcEx0z9DCLet
 lUCVjqQ7y0FZrSM9Tbm71KhwKKvXag0KCyCcmL/nDH2Gh69LjC74/GFbLcfv85nqXrnJVGH+PRX
 EBjmamvjWPfNAoxpOsCH+wR5q92ZGrL6FsmoLOCYZk+YLqBYaR2z0ILowPMwF4e1W65IIJ8wzE0
 t4D0Of/BTJiUEYTRLWf3/FZF0Aa0eQjL9gTSHnv9B2oct94w+gxR1+NOaPr6gOL+QZHPsLP2HWy
 yAwa/8mY5ozKi315oBvwrLEEH20oLXj3fqVbTdPTegglDFWYJu57HyC6zD+oA+t1CidNk0DB7ds
 ivmku8CgGgMB+YIwkUy7EILhxpBmBmHwiD1S6q3ScN1Xq/frChBBmn6y/K/dTtpmjo2ZzHJws3G
 MuxNDvvnoirO3GUTbEy02dTBZMhoZoLjrtlwLT5zfy9xIYl06vMf4TK4pY6jjpDpPI03k2jgrU9
 tmLyntmFW7hlspg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Wed, 23 Sep 2026 05:55:32 +0800, Yonggang Luo <luoyonggang@gmail.com> wrote:
> query-machines returned only the -M name, so management apps inferred
> the QOM type as that name plus "-machine". A prefixed type such as
> arm-virt-11.1-machine no longer matches -M virt-11.1. Return the QOM
> type in MachineInfo typename from object_class_get_name() in
> qmp_query_machines(). test_query_machines_typename checks that
> qom-list-properties accepts it.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


