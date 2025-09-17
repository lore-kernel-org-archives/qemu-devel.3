Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4FCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 13:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrt0-0003A4-Gv; Wed, 17 Sep 2025 09:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyrqk-0006rf-2E
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:05:32 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uyrqc-0006O6-6v
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 09:05:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cRf8h5Hw5z6GDKy;
 Wed, 17 Sep 2025 21:03:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id A811A1400CB;
 Wed, 17 Sep 2025 21:05:05 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Sep
 2025 15:05:05 +0200
Date: Wed, 17 Sep 2025 14:05:03 +0100
To: Peter Maydell <peter.maydell@linaro.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, <qemu-devel@nongnu.org>, "Vinayak
 Holikatti" <vinayak.kh@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 03/27] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands cxl r3.2 (8.2.10.9.5.3)
Message-ID: <20250917140503.0000231b@huawei.com>
In-Reply-To: <CAFEAcA-p5wZkNxK7wNVq_3PAzEE-muOd1Def-0O-FSpck4DrBQ@mail.gmail.com>
References: <cover.1747223385.git.mst@redhat.com>
 <77a8e9fe0ecb71b260d17f43221df5b18769b359.1747223385.git.mst@redhat.com>
 <CAFEAcA-p5wZkNxK7wNVq_3PAzEE-muOd1Def-0O-FSpck4DrBQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 10 Jul 2025 14:26:07 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Wed, 14 May 2025 at 12:50, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > From: Vinayak Holikatti <vinayak.kh@samsung.com>
> >
> > CXL spec 3.2 section 8.2.10.9.5.3 describes media operations commands.
> > CXL devices supports media operations discovery command.
> >
> > Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Message-Id: <20250305092501.191929-4-Jonathan.Cameron@huawei.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 125 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 125 insertions(+)  
> 
> 
> 
> > +static CXLRetCode media_operations_discovery(uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out)
> > +{
> > +    struct {
> > +        uint8_t media_operation_class;
> > +        uint8_t media_operation_subclass;
> > +        uint8_t rsvd[2];
> > +        uint32_t dpa_range_count;
> > +        struct {
> > +            uint16_t start_index;
> > +            uint16_t num_ops;
> > +        } discovery_osa;
> > +    } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
> > +    struct media_op_discovery_out_pl *media_out_pl =
> > +        (struct media_op_discovery_out_pl *)payload_out;
> > +    int num_ops, start_index, i;
> > +    int count = 0;
> > +
> > +    if (len_in < sizeof(*media_op_in_disc_pl)) {
> > +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> > +    }
> > +
> > +    num_ops = media_op_in_disc_pl->discovery_osa.num_ops;
> > +    start_index = media_op_in_disc_pl->discovery_osa.start_index;
> > +
> > +    /*
> > +     * As per spec CXL r3.2 8.2.10.9.5.3 dpa_range_count should be zero and
> > +     * start index should not exceed the total number of entries for discovery
> > +     * sub class command.
> > +     */
> > +    if (media_op_in_disc_pl->dpa_range_count ||
> > +        start_index > ARRAY_SIZE(media_op_matrix)) {  
> 
> Coverity thinks this bounds check is wrong (CID 1610091):
> we allow start_index equal to the ARRAY_SIZE(media_op_matrix),
> which means that in the loop below we will index off the
> end of the array.
> 
> Don't we also need to be checking (start_index + num_ops)
> against the array size bounds, not just start_index ?

Agreed. I think this should be
start_index + num_ops > ARRAY_SIZE(media_op_matrix);


> 
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
> > +    media_out_pl->total_supported_operations =
> > +                                     ARRAY_SIZE(media_op_matrix);
> > +    if (num_ops > 0) {
> > +        for (i = start_index; i < start_index + num_ops; i++) {
> > +            media_out_pl->entry[count].media_op_class =
> > +                    media_op_matrix[i].media_op_class;
> > +            media_out_pl->entry[count].media_op_subclass =
> > +                        media_op_matrix[i].media_op_subclass;
> > +            count++;
> > +            if (count == num_ops) {
> > +                break;
> > +            }
> > +        }
> > +    }
> > +
> > +    media_out_pl->num_of_supported_operations = count;
> > +    *len_out = sizeof(*media_out_pl) + count * sizeof(*media_out_pl->entry);
> > +    return CXL_MBOX_SUCCESS;
> > +}  
> 
> The functions in this patch also look like they aren't correctly
> handling the "guest and host endianness differ" case.

The fields in CXL mailbox commands are all defined as little endian.
There is a problem with littlendian vs guest.  That's true of a lot
of the CXL code and something that needs a thorough audit at some point.
I'll leave this for now.  Given how slow emulating an big endian system
is it's rather a marathon effort to test any such fixes.

I'll sort out a fix for the issue in previous patch as well.

Thanks,

Jonathan


> 
> thanks
> -- PMM


