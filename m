Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE950EEF316
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy3TO-00034R-QS; Thu, 05 Mar 2026 02:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy3TN-00033o-7J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vy3TL-0006Uc-4r
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 02:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772697013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HIcNXgMpJZ11JrknsmUrrE7jshRlWJZSnecU9L3m2Eo=;
 b=daIwP1g6xY8EW8FHHwSBykdJPSOtFmo1wLn6LsPzAzMbi5bXfEbCDPsJSFaQQ/ZnjK1uhP
 6Zt/VUv0PnxVHiLXhwtpMzR+O4xEr+o6RdGlzsbnBh+oTdiPZGWgBGtqQ73tMePQMCx98Y
 jnEJZ3ouymgQO7GiFxqJ6i1dTobd0Z8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-Qp4Toyk2NdGYyM0Wy4W6MA-1; Thu,
 05 Mar 2026 02:50:08 -0500
X-MC-Unique: Qp4Toyk2NdGYyM0Wy4W6MA-1
X-Mimecast-MFC-AGG-ID: Qp4Toyk2NdGYyM0Wy4W6MA_1772697007
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21C701956061; Thu,  5 Mar 2026 07:50:07 +0000 (UTC)
Received: from [10.45.224.75] (unknown [10.45.224.75])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E373180049D; Thu,  5 Mar 2026 07:50:00 +0000 (UTC)
Message-ID: <0254ffe7-1397-4be3-9211-0213d2f45e02@redhat.com>
Date: Thu, 5 Mar 2026 08:49:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] hw/net/e1000: Remove unused E1000_FLAG_TSO flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250501230129.2596-1-philmd@linaro.org>
 <20250501230129.2596-7-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250501230129.2596-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

On 02/05/2025 01.01, Philippe Mathieu-Daudé wrote:
> E1000_FLAG_TSO was only used by the hw_compat_2_11[] array,
> via the 'migrate_tso_props=off' property. We removed all
> machines using that array, lets remove all the code around
> E1000_FLAG_TSO, including the vmstate_e1000_tx_tso_state
> subsection.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Is it OK to remove migration subsection like that?
> ---
>   hw/net/e1000.c | 58 +++++++-------------------------------------------
>   1 file changed, 8 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index e0310aef872..c68645684b6 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -127,13 +127,10 @@ struct E1000State_st {
>       QEMUTimer *flush_queue_timer;
>   
>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
> -#define E1000_FLAG_TSO_BIT 3
>   #define E1000_FLAG_VET_BIT 4
> -#define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>   
>       uint32_t compat_flags;
> -    bool received_tx_tso;
>       bool use_tso_for_migration;
>       e1000x_txd_props mig_props;
>   };
> @@ -1331,7 +1328,7 @@ static int e1000_pre_save(void *opaque)
>       }
>   
>       /* Decide which set of props to migrate in the main structure */
> -    if (chkflag(TSO) || !s->use_tso_for_migration) {
> +    if (!s->use_tso_for_migration) {
>           /* Either we're migrating with the extra subsection, in which
>            * case the mig_props is always 'props' OR
>            * we've not got the subsection, but 'props' was the last
> @@ -1368,30 +1365,16 @@ static int e1000_post_load(void *opaque, int version_id)
>       }
>   
>       s->tx.props = s->mig_props;
> -    if (!s->received_tx_tso) {
> -        /* We received only one set of offload data (tx.props)
> -         * and haven't got tx.tso_props.  The best we can do
> -         * is dupe the data.
> -         */
> -        s->tx.tso_props = s->mig_props;
> -    }
> +
> +    /* We received only one set of offload data (tx.props)
> +     * and haven't got tx.tso_props.  The best we can do
> +     * is dupe the data.
> +     */
> +    s->tx.tso_props = s->mig_props;
> +
>       return 0;
>   }
>   
> -static int e1000_tx_tso_post_load(void *opaque, int version_id)
> -{
> -    E1000State *s = opaque;
> -    s->received_tx_tso = true;
> -    return 0;
> -}
> -
> -static bool e1000_tso_state_needed(void *opaque)
> -{
> -    E1000State *s = opaque;
> -
> -    return chkflag(TSO);
> -}
> -
>   static const VMStateDescription vmstate_e1000_mit_state = {
>       .name = "e1000/mit_state",
>       .version_id = 1,
> @@ -1416,28 +1399,6 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
>       }
>   };
>   
> -static const VMStateDescription vmstate_e1000_tx_tso_state = {
> -    .name = "e1000/tx_tso_state",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = e1000_tso_state_needed,
> -    .post_load = e1000_tx_tso_post_load,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
> -        VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
> -        VMSTATE_UINT16(tx.tso_props.ipcse, E1000State),
> -        VMSTATE_UINT8(tx.tso_props.tucss, E1000State),
> -        VMSTATE_UINT8(tx.tso_props.tucso, E1000State),
> -        VMSTATE_UINT16(tx.tso_props.tucse, E1000State),
> -        VMSTATE_UINT32(tx.tso_props.paylen, E1000State),
> -        VMSTATE_UINT8(tx.tso_props.hdr_len, E1000State),
> -        VMSTATE_UINT16(tx.tso_props.mss, E1000State),
> -        VMSTATE_INT8(tx.tso_props.ip, E1000State),
> -        VMSTATE_INT8(tx.tso_props.tcp, E1000State),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>   static const VMStateDescription vmstate_e1000 = {
>       .name = "e1000",
>       .version_id = 2,
> @@ -1519,7 +1480,6 @@ static const VMStateDescription vmstate_e1000 = {
>       .subsections = (const VMStateDescription * const []) {
>           &vmstate_e1000_mit_state,
>           &vmstate_e1000_full_mac_state,
> -        &vmstate_e1000_tx_tso_state,

Uh, this looks wrong? The bit is enabled by default, so shouldn't the 
subsection be always used unconditionally now instead?

  Thomas


>           NULL
>       }
>   };
> @@ -1637,8 +1597,6 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
>   
>   static const Property e1000_properties[] = {
>       DEFINE_NIC_PROPERTIES(E1000State, conf),
> -    DEFINE_PROP_BIT("migrate_tso_props", E1000State,
> -                    compat_flags, E1000_FLAG_TSO_BIT, true),
>       DEFINE_PROP_BIT("init-vet", E1000State,
>                       compat_flags, E1000_FLAG_VET_BIT, true),
>   };


