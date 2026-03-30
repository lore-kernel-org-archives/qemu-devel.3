Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C1FF4947
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w75O0-0006DU-S0; Mon, 30 Mar 2026 01:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w75Nq-0006Ch-16
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:41:55 -0400
Received: from smtpout1.mo534.mail-out.ovh.net ([51.210.94.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1w75Nl-0000Rj-RQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:41:53 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4fkg9P6nt7z6Bwx
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:41:45 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:41:45 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.164.13])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4fkg9P5Dvnz5vgL
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:41:45 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 81E191923979
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:41:45 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002ee8c894b-630b-426b-8e21-22ca0fb555bb,
 7D556D2DDFF67F75045F04EBDED03CA4E39E484C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <42a44467-ba26-42cd-9e56-d687b7e5255f@kaod.org>
Date: Mon, 30 Mar 2026 07:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/ftgmac100: preserve full VLAN TCI in TX tag insertion
To: qemu-devel@nongnu.org
References: <1471e413d3589b6734819bda2b59b725b74f273a.d551129b.99fc.47f6.86dc.0759227268a2@feishu.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <1471e413d3589b6734819bda2b59b725b74f273a.d551129b.99fc.47f6.86dc.0759227268a2@feishu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 943785600634760203
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTEw7rXryZvNcH2i4s2WytF6qw3Ut/Gsw4eLNzbRAd04uZW5PHQV8aeM63VJAIC2fs3uwkVPnG1M/TEW7g+rh79dvC+azMhaCgBJoOxI4/MDfmNjSHDTWnsgRNy3ISmGSc1FKBQ6tK2rA/jUZEinHNMSudabLeHGAEk4OAcmR7ys91L47wi38M8EUsNo2DoMD8GV++mwVd5x96LRrFT7y7tBpdfOu1yJuYObmSrxN0uof7HrmHEEqNQFLJGuuLWTVUhFGJh1/7dYFPZvALe3oo6CxPnlqr5wCfuoyit0yPETneYkjEo2IWuMDsJud0fEfm7yB5nnoIRNs2+2zw2QzAqpe7cnOYOr0gj8elYLYYXHw5650Y6o3TulBLHPgxQp9eOFqBzMi2hunJ+mYuSjLoAE4e94l6OpTEOOF/bWMIZuoVxjH9NqT623VVSI/3Z3j3CFQXggBf4e3FP3LyblFaUzC+DmO3s8xTndRXKVSdLLSvCc7ubeMhuu7jhNrIC4l+NCOQSpozvEU6S/mGFxF1AuFCtocRaAoeLk8Fs/YNb9uNWoFB3Q2lP3RK+w7w+5Cdgi77nL+3sxExnuOKZJS3aEqSUqx3sjR2ZDxPJNAghl+9Blh6b7kX1iWD6cWmCWQsf9R5s/PSs2LBbQ744t1vmgu1W3+j/SKn9VlBIy/BdYPA
DKIM-Signature: a=rsa-sha256; bh=eAIf4rGgEMPa64Fv2bLAh9avk9qms9C3xnH57NSNI3M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1774849306; v=1;
 b=hVzgsqpg3aZMwk72HJNv75N3BklA/mSJrL/r1bNVlofqnHBjwJm9ofpOTe/r/GAgusUIcE2o
 a8scSMYBjQk9K/mSOsqOaGvUrSpjKAGlrBzWRnw4svMYAM8RS9x+GkFwcyGMYHJm+hTuhcCEC9g
 vyzDYdBeV3zdyZN4czMlLrN1GBUiFIH70f4C4GGWNKaIF6XV/Oud9YALpnVtf1oisX/wQyIW6Xs
 tREc+/PJWgMF2d4FTOqjDIFGmaNoq3KMllnT1QUnFAAxU2cw5xu+vUQ58lVCMr7mFEmzYWqt2XM
 Yu23plcYnTjsZNZu4ejsasZj6y425z56FAmriE6YWNyeg==
Received-SPF: pass client-ip=51.210.94.140; envelope-from=clg@kaod.org;
 helo=smtpout1.mo534.mail-out.ovh.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/27/26 08:39, linhuang wrote:
> 
> The VLAN tag insertion helper took vlan_tci as an 8-bit value, while
> the descriptor provides a 16-bit VLAN TCI. This truncated egress tags
> and caused VLAN ID corruption (for example, 4088/0x0ff8 became
> 248/0x00f8 at the receiver).
> 
> Change vlan_tci to uint16_t in the TX VLAN insertion path so the full
> 802.1Q TCI is preserved and transmitted correctly.
> 
> Signed-off-by: linhuang <linhuang@ruijie.com.cn <mailto:linhuang@ruijie.com.cn>>
> ---
>   hw/net/ftgmac100.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 2f05bba11d..b3da48c343 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -498,7 +498,7 @@ static int ftgmac100_write_bd(FTGMAC100Desc *bd, dma_addr_t addr)
>   }
> 
>   static int ftgmac100_insert_vlan(FTGMAC100State *s, int frame_size,
> -                                  uint8_t vlan_tci)
> +                                 uint16_t vlan_tci)
>   {
>       uint8_t *vlan_hdr = s->frame + (ETH_ALEN * 2);
>       uint8_t *payload = vlan_hdr + sizeof(struct vlan_header);
> --
> 2.34.1

Applied to aspeed-next.

Thanks,

C.


