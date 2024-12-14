Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC02CE77180
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 06:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMM4T-0006iQ-Tq; Sat, 14 Dec 2024 01:56:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tMM4S-0006iB-4M
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:56:12 -0500
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tMM4O-0004x1-Sp
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 01:56:11 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.108.25.244])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4Y9H6V0sgTz10G4;
 Sat, 14 Dec 2024 06:56:02 +0000 (UTC)
Received: from kaod.org (37.59.142.108) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 14 Dec
 2024 07:56:01 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S0022c799553-3930-475f-b5a9-a412d099ab2e,
 7F0875366495B486867DF4DA7C1512417F974EE7) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.113.106.80
Date: Sat, 14 Dec 2024 07:56:00 +0100
From: Greg Kurz <groug@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Christian
 Schoenebeck" <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 12/71] hw/9pfs: Constify all Property
Message-ID: <20241214075600.49a57f89@bahia>
In-Reply-To: <20241213190750.2513964-17-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-17-richard.henderson@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.108]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 14d6a2f0-dd1c-408d-8a69-63bf6caddca7
X-Ovh-Tracer-Id: 3171097087764503008
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeekgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdekpdejkedruddufedruddtiedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdpnhgspghrtghpthhtohepgedprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdfovfetjfhoshhtpehmohehvdelmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=0dMfaA8s5t30AtxJIZGz8Rl5VUoVGRQSYM6Ys8saa00=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1734159362; v=1;
 b=piHqg0kFJCI7urxIHJnMh6CAYV/OQjMYFMsrkw6EasXnfDSTcvDJ4SBAS+Xp1o+UPsIr5Yen
 EX/LPr3XQMEffMGN/Y8M76XwGY0e8CsaTlRwezDmsiCYYO1ZkOQdjUlcJd5iNbnHv8RdxRCwE1+
 +GBZ/j5k5KKsDmEvKc3yG2bgmIXutkLQgj36pFO9XqUnLT8fZO5gwpE+mJSGjGZrT4CEdXGI2Vn
 E4I3yxKxOSbWdGcVJpJNkVPP/lEEax9yOm2dChLU4fj0OKQ8yHxT5nuymydsHnsg64h8AjZD7Br
 26FRHLZNpSgU3XV11fBJX/iSmnZ0AS2Cu5KS2apfXJ/BQ==
Received-SPF: pass client-ip=46.105.54.81; envelope-from=groug@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 13 Dec 2024 13:06:46 -0600
Richard Henderson <richard.henderson@linaro.org> wrote:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/virtio-9p-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index efa41cfd73..b764e4cd3d 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -243,7 +243,7 @@ static const VMStateDescription vmstate_virtio_9p = {
>      },
>  };
>  
> -static Property virtio_9p_properties[] = {
> +static const Property virtio_9p_properties[] = {
>      DEFINE_PROP_STRING("mount_tag", V9fsVirtioState, state.fsconf.tag),
>      DEFINE_PROP_STRING("fsdev", V9fsVirtioState, state.fsconf.fsdev_id),
>      DEFINE_PROP_END_OF_LIST(),



-- 
Greg

