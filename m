Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B87EC1106
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 16:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuYlZ-0007AI-Eo; Mon, 23 Feb 2026 11:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuYlP-00072r-9g
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:26:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vuYlN-00010z-C0
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771863984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y8mECu8+ZWGJA7JGjU8lbyPSx2UnlkXZ8r71kPl1YoM=;
 b=QBGf1x6KRJf0WvrPVZCXktlbd0Z/QRSpuVJEV/9mObAbV80SszkC1Q0O3vuXqSzctbKCbC
 1O2q4eol8Fjln9rQwlw2bwTvklw1KfwVQ3FjSF483gFPF13gVK/clLFeAZusPYumy8rb5v
 SgN9MF6sXg5tSJwQJUFrypwtUeHH8Nc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-NrDWLf1VNum7NK4YD3J1Yw-1; Mon,
 23 Feb 2026 11:26:18 -0500
X-MC-Unique: NrDWLf1VNum7NK4YD3J1Yw-1
X-Mimecast-MFC-AGG-ID: NrDWLf1VNum7NK4YD3J1Yw_1771863977
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EB3D195608D; Mon, 23 Feb 2026 16:26:17 +0000 (UTC)
Received: from [10.45.224.205] (unknown [10.45.224.205])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B865B1955F22; Mon, 23 Feb 2026 16:26:14 +0000 (UTC)
Message-ID: <89379aba-1e0f-46d3-834a-2cb7d78c765c@redhat.com>
Date: Mon, 23 Feb 2026 17:26:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
 <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/02/2026 19.45, BALATON Zoltan wrote:
> On Tue, 27 Jan 2026, BALATON Zoltan wrote:
>> The do_interrupt parameter for rtl8139_do_receive was originally added
>> in commit 6cadb320c7 to avoid generating interrupt when receiving in
>> loopback mode. Later commit 5311fb805a changed this so that this
>> parameter became ineffective and now this parameter is unused and
>> always 1. If this turns out to be a problem maybe there's a better way
>> to fix this so remove the do_interrupt parameter for now to simplify
>> code.
> 
> Ping?

... it's not a very complicated patch, so maybe this could also go via 
qemu-trivial? (now on CC:)

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> hw/net/rtl8139.c | 24 ++++++++----------------
>> 1 file changed, 8 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
>> index 9fd00574d2..2ad6338ebe 100644
>> --- a/hw/net/rtl8139.c
>> +++ b/hw/net/rtl8139.c
>> @@ -815,7 +815,8 @@ static bool rtl8139_can_receive(NetClientState *nc)
>>     return avail == 0 || avail >= 1514 || (s->IntrMask & RxOverflow);
>> }
>>
>> -static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, 
>> size_t size_, int do_interrupt)
>> +static ssize_t rtl8139_receive(NetClientState *nc,
>> +                               const uint8_t *buf, size_t size_)
>> {
>>     RTL8139State *s = qemu_get_nic_opaque(nc);
>>     PCIDevice *d = PCI_DEVICE(s);
>> @@ -1173,20 +1174,11 @@ static ssize_t rtl8139_do_receive(NetClientState 
>> *nc, const uint8_t *buf, size_t
>>     }
>>
>>     s->IntrStatus |= RxOK;
>> -
>> -    if (do_interrupt)
>> -    {
>> -        rtl8139_update_irq(s);
>> -    }
>> +    rtl8139_update_irq(s);
>>
>>     return size_;
>> }
>>
>> -static ssize_t rtl8139_receive(NetClientState *nc, const uint8_t *buf, 
>> size_t size)
>> -{
>> -    return rtl8139_do_receive(nc, buf, size, 1);
>> -}
>> -
>> static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
>> {
>>     s->RxBufferSize = bufferSize;
>> @@ -1745,7 +1737,7 @@ static uint32_t rtl8139_RxConfig_read(RTL8139State *s)
>> }
>>
>> static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
>> -    int do_interrupt, const uint8_t *dot1q_buf)
>> +                                   const uint8_t *dot1q_buf)
>> {
>>     struct iovec *iov = NULL;
>>     struct iovec vlan_iov[3];
>> @@ -1828,7 +1820,7 @@ static int rtl8139_transmit_one(RTL8139State *s, int 
>> descriptor)
>>     s->TxStatus[descriptor] |= TxHostOwns;
>>     s->TxStatus[descriptor] |= TxStatOK;
>>
>> -    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
>> +    rtl8139_transfer_frame(s, txbuffer, txsize, NULL);
>>
>>     DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
>>         descriptor);
>> @@ -2246,7 +2238,7 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
>>                     DPRINTF("+++ C+ mode TSO transferring packet size "
>>                         "%d\n", tso_send_size);
>>                     rtl8139_transfer_frame(s, saved_buffer, tso_send_size,
>> -                        0, (uint8_t *) dot1q_buffer);
>> +                                           (uint8_t *)dot1q_buffer);
>>
>>                     /* add transferred count to TCP sequence number */
>>                     stl_be_p(&p_tcp_hdr->th_seq,
>> @@ -2323,8 +2315,8 @@ skip_offload:
>>
>>         DPRINTF("+++ C+ mode transmitting %d bytes packet\n", saved_size);
>>
>> -        rtl8139_transfer_frame(s, saved_buffer, saved_size, 1,
>> -            (uint8_t *) dot1q_buffer);
>> +        rtl8139_transfer_frame(s, saved_buffer, saved_size,
>> +                               (uint8_t *)dot1q_buffer);
>>
>>         /* restore card space if there was no recursion and reset offset */
>>         if (!s->cplus_txbuffer)
>>
> 


