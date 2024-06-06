Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA0C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 13:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDWv-0005b1-HV; Thu, 06 Jun 2024 09:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sFDWt-0005ae-TI
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:51:47 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sFDWq-0000bH-6i
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 09:51:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AC1121AFA;
 Thu,  6 Jun 2024 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717681902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhjLDQXFte4X8FlB15+41tSe3FVCPG7ZGDM5PKC/eLI=;
 b=BZQGIOkkE6ALhN3ABFkT6ozVcvyDTOo6w5yoes91PChU1FpAFZuGKUsSzoTaiQj/m+jpXd
 kxfmPI9sCW8tfpWmmq58YdQrGmTtNd9tnIKadHK+W+5VAVNVPV3klxAWkf/1BjiyYzBxT2
 2rm5+YAzNwt8b6NIlKjm1rJjwgBt2EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717681902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhjLDQXFte4X8FlB15+41tSe3FVCPG7ZGDM5PKC/eLI=;
 b=Cncll4QCoqIBYs1TekggnzjsfBuYrQUr7n6KPZ36fRe6vV55yheWaQdsEuIjDb4f0QMme1
 gtkbIOboRXcSieCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y14uoFiz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="u0foE/Q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717681901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhjLDQXFte4X8FlB15+41tSe3FVCPG7ZGDM5PKC/eLI=;
 b=Y14uoFizLW9F6sLq6BABkvnCur9Kta2NK85c/YvJZgOu68iBaY1EMB0GWrlEZiVh0k2Ds4
 Ss2sEuw/XK2zmR+HkZvqPEZKXCJ01F7Jvf+a1XkuU8HRvQ7lLPJ5T5KY32ifL+sB2X41zj
 dF2z1PrQLqbWVqTcz6eyKipQyYjrG80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717681901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lhjLDQXFte4X8FlB15+41tSe3FVCPG7ZGDM5PKC/eLI=;
 b=u0foE/Q/VNrk2FLeLxd0DYG0gMjiqy4/Q/OLNSWgUqW1InSulmO6PA4Pj/ZuUnG0VYM8P1
 Bww4LZSk6XtPTZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C0013A79;
 Thu,  6 Jun 2024 13:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vWdVNuy+YWYTUAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Jun 2024 13:51:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Liu, Yuan1" <yuan1.liu@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "thuth@redhat.com"
 <thuth@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v7 6/7] migration/multifd: implement qpl compression and
 decompression
In-Reply-To: <MW4PR11MB59366D87600EA832A8248F2FA3FA2@MW4PR11MB5936.namprd11.prod.outlook.com>
References: <20240603154106.764378-1-yuan1.liu@intel.com>
 <20240603154106.764378-7-yuan1.liu@intel.com> <87plsvni18.fsf@suse.de>
 <MW4PR11MB59366D87600EA832A8248F2FA3FA2@MW4PR11MB5936.namprd11.prod.outlook.com>
Date: Thu, 06 Jun 2024 10:51:38 -0300
Message-ID: <87frtqnpqt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_EQ_ADDR_SOME(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[10]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AC1121AFA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Liu, Yuan1" <yuan1.liu@intel.com> writes:

>> -----Original Message-----
>> From: Fabiano Rosas <farosas@suse.de>
>> Sent: Thursday, June 6, 2024 6:26 AM
>> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
>> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
>> thuth@redhat.com; philmd@linaro.org
>> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
>> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
>> Subject: Re: [PATCH v7 6/7] migration/multifd: implement qpl compression
>> and decompression
>> 
>> Yuan Liu <yuan1.liu@intel.com> writes:
>> 
>> > QPL compression and decompression will use IAA hardware first.
>> > If IAA hardware is not available, it will automatically fall
>> > back to QPL software path, if the software job also fails,
>> > the uncompressed page is sent directly.
>> >
>> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
>> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>> > ---
>> >  migration/multifd-qpl.c | 412 +++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 408 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
>> > index 6791a204d5..18b3384bd5 100644
>> > --- a/migration/multifd-qpl.c
>> > +++ b/migration/multifd-qpl.c
>> > @@ -13,9 +13,14 @@
>> >  #include "qemu/osdep.h"
>> >  #include "qemu/module.h"
>> >  #include "qapi/error.h"
>> > +#include "qapi/qapi-types-migration.h"
>> > +#include "exec/ramblock.h"
>> >  #include "multifd.h"
>> >  #include "qpl/qpl.h"
>> >
>> > +/* Maximum number of retries to resubmit a job if IAA work queues are
>> full */
>> > +#define MAX_SUBMIT_RETRY_NUM (3)
>> > +
>> >  typedef struct {
>> >      /* the QPL hardware path job */
>> >      qpl_job *job;
>> > @@ -260,6 +265,219 @@ static void
>> multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
>> >      p->iov = NULL;
>> >  }
>> >
>> > +/**
>> > + * multifd_qpl_prepare_job: prepare the job
>> > + *
>> > + * Set the QPL job parameters and properties.
>> > + *
>> > + * @job: pointer to the qpl_job structure
>> > + * @is_compression: indicates compression and decompression
>> > + * @input: pointer to the input data buffer
>> > + * @input_len: the length of the input data
>> > + * @output: pointer to the output data buffer
>> > + * @output_len: the length of the output data
>> > + */
>> > +static void multifd_qpl_prepare_job(qpl_job *job, bool is_compression,
>> > +                                    uint8_t *input, uint32_t input_len,
>> > +                                    uint8_t *output, uint32_t
>> output_len)
>> > +{
>> > +    job->op = is_compression ? qpl_op_compress : qpl_op_decompress;
>> > +    job->next_in_ptr = input;
>> > +    job->next_out_ptr = output;
>> > +    job->available_in = input_len;
>> > +    job->available_out = output_len;
>> > +    job->flags = QPL_FLAG_FIRST | QPL_FLAG_LAST | QPL_FLAG_OMIT_VERIFY;
>> > +    /* only supports compression level 1 */
>> > +    job->level = 1;
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_prepare_job: prepare the compression job
>> 
>> function name is wrong
>
> Thanks, I will fix this next version.
>  
>> > + *
>> > + * Set the compression job parameters and properties.
>> > + *
>> > + * @job: pointer to the qpl_job structure
>> > + * @input: pointer to the input data buffer
>> > + * @input_len: the length of the input data
>> > + * @output: pointer to the output data buffer
>> > + * @output_len: the length of the output data
>> > + */
>> > +static void multifd_qpl_prepare_comp_job(qpl_job *job, uint8_t *input,
>> > +                                         uint32_t input_len, uint8_t
>> *output,
>> > +                                         uint32_t output_len)
>> > +{
>> > +    multifd_qpl_prepare_job(job, true, input, input_len, output,
>> output_len);
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_prepare_job: prepare the decompression job
>
> Thanks, I will fix this next version.
>  
>> > + *
>> > + * Set the decompression job parameters and properties.
>> > + *
>> > + * @job: pointer to the qpl_job structure
>> > + * @input: pointer to the input data buffer
>> > + * @input_len: the length of the input data
>> > + * @output: pointer to the output data buffer
>> > + * @output_len: the length of the output data
>> > + */
>> > +static void multifd_qpl_prepare_decomp_job(qpl_job *job, uint8_t
>> *input,
>> > +                                           uint32_t input_len, uint8_t
>> *output,
>> > +                                           uint32_t output_len)
>> > +{
>> > +    multifd_qpl_prepare_job(job, false, input, input_len, output,
>> output_len);
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_fill_iov: fill in the IOV
>> > + *
>> > + * Fill in the QPL packet IOV
>> > + *
>> > + * @p: Params for the channel being used
>> > + * @data: pointer to the IOV data
>> > + * @len: The length of the IOV data
>> > + */
>> > +static void multifd_qpl_fill_iov(MultiFDSendParams *p, uint8_t *data,
>> > +                                 uint32_t len)
>> > +{
>> > +    p->iov[p->iovs_num].iov_base = data;
>> > +    p->iov[p->iovs_num].iov_len = len;
>> > +    p->iovs_num++;
>> > +    p->next_packet_size += len;
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_fill_packet: fill the compressed page into the QPL
>> packet
>> > + *
>> > + * Fill the compressed page length and IOV into the QPL packet
>> > + *
>> > + * @idx: The index of the compressed length array
>> > + * @p: Params for the channel being used
>> > + * @data: pointer to the compressed page buffer
>> > + * @len: The length of the compressed page
>> > + */
>> > +static void multifd_qpl_fill_packet(uint32_t idx, MultiFDSendParams *p,
>> > +                                    uint8_t *data, uint32_t len)
>> > +{
>> > +    QplData *qpl = p->compress_data;
>> > +
>> > +    qpl->zlen[idx] = cpu_to_be32(len);
>> > +    multifd_qpl_fill_iov(p, data, len);
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_submit_job: submit a job to the hardware
>> > + *
>> > + * Submit a QPL hardware job to the IAA device
>> > + *
>> > + * Returns true if the job is submitted successfully, otherwise false.
>> > + *
>> > + * @job: pointer to the qpl_job structure
>> > + */
>> > +static bool multifd_qpl_submit_job(qpl_job *job)
>> > +{
>> > +    qpl_status status;
>> > +    uint32_t num = 0;
>> > +
>> > +retry:
>> > +    status = qpl_submit_job(job);
>> > +    if (status == QPL_STS_QUEUES_ARE_BUSY_ERR) {
>> > +        if (num < MAX_SUBMIT_RETRY_NUM) {
>> > +            num++;
>> > +            goto retry;
>> > +        }
>> > +    }
>> > +    return (status == QPL_STS_OK);
>> 
>> How often do we expect this to fail? Will the queues be busy frequently
>> or is this an unlikely event? I'm thinking whether we really need to
>> allow a fallback for the hw path. Sorry if this has been discussed
>> already, I don't remember.
>
> In some scenarios, this may happen frequently, such as configuring 4 channels 
> but only one IAA device is available. In the case of insufficient IAA hardware 
> resources, retry and fallback can help optimize performance.
> I have a comparison test below
>
> 1. Retry + SW fallback:
>    total time: 14649 ms
>    downtime: 25 ms
>    throughput: 17666.57 mbps
>    pages-per-second: 1509647
>
> 2. No fallback, always wait for work queues to become available
>    total time: 18381 ms
>    downtime: 25 ms
>    throughput: 13698.65 mbps
>    pages-per-second: 859607

Thanks for the data, this is helpful. Let's include it in the commit
message, it's important to let people know you actually did that
analysis. I put a suggestion below:

---
QPL compression and decompression will use IAA hardware path if the IAA
hardware is available. Otherwise the QPL library software path is used.

The hardware path will automatically fall back to QPL software path if
the IAA queues are busy. In some scenarios, this may happen frequently,
such as configuring 4 channels but only one IAA device is available. In
the case of insufficient IAA hardware resources, retry and fallback can
help optimize performance:

 1. Retry + SW fallback:
    total time: 14649 ms
    downtime: 25 ms
    throughput: 17666.57 mbps
    pages-per-second: 1509647

 2. No fallback, always wait for work queues to become available
    total time: 18381 ms
    downtime: 25 ms
    throughput: 13698.65 mbps
    pages-per-second: 859607

If both the hardware and software paths fail, the uncompressed page is
sent directly.

>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_compress_pages_slow_path: compress pages using slow path
>> > + *
>> > + * Compress the pages using software. If compression fails, the page
>> will
>> > + * be sent directly.
>> > + *
>> > + * @p: Params for the channel being used
>> > + */
>> > +static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
>> > +{
>> > +    QplData *qpl = p->compress_data;
>> > +    uint32_t size = p->page_size;
>> > +    qpl_job *job = qpl->sw_job;
>> > +    uint8_t *zbuf = qpl->zbuf;
>> > +    uint8_t *buf;
>> > +
>> > +    for (int i = 0; i < p->pages->normal_num; i++) {
>> > +        buf = p->pages->block->host + p->pages->offset[i];
>> > +        /* Set output length to less than the page to reduce
>> decompression */
>> > +        multifd_qpl_prepare_comp_job(job, buf, size, zbuf, size - 1);
>> > +        if (qpl_execute_job(job) == QPL_STS_OK) {
>> > +            multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
>> > +        } else {
>> > +            /* send the page directly */
>> 
>> s/directly/uncompressed/
>> 
>> a bit clearer.
>
> Sure, I will fix it next version. 
>
>> > +            multifd_qpl_fill_packet(i, p, buf, size);
>> > +        }
>> > +        zbuf += size;
>> > +    }
>> > +}
>> > +
>> > +/**
>> > + * multifd_qpl_compress_pages: compress pages
>> > + *
>> > + * Submit the pages to the IAA hardware for compression. If hardware
>> > + * compression fails, it falls back to software compression. If
>> software
>> > + * compression also fails, the page is sent directly
>> > + *
>> > + * @p: Params for the channel being used
>> > + */
>> > +static void multifd_qpl_compress_pages(MultiFDSendParams *p)
>> > +{
>> > +    QplData *qpl = p->compress_data;
>> > +    MultiFDPages_t *pages = p->pages;
>> > +    uint32_t size = p->page_size;
>> > +    QplHwJob *hw_job;
>> > +    uint8_t *buf;
>> > +    uint8_t *zbuf;
>> > +
>> 
>> Let's document the output size choice more explicitly:
>> 
>>     /*
>>      * Set output length to less than the page size to force the job to
>>      * fail in case it compresses to a larger size. We'll send that page
>>      * without compression and skip the decompression operation on the
>>      * destination.
>>      */
>>      out_size = size - 1;
>> 
>> you can then omit the other comments.
>
> Thanks for the comments, I will refine this next version.
>  
>> > +    for (int i = 0; i < pages->normal_num; i++) {
>> > +        buf = pages->block->host + pages->offset[i];
>> > +        zbuf = qpl->zbuf + (size * i);
>> > +        hw_job = &qpl->hw_jobs[i];
>> > +        /* Set output length to less than the page to reduce
>> decompression */
>> > +        multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf, size
>> - 1);
>> > +        if (multifd_qpl_submit_job(hw_job->job)) {
>> > +            hw_job->fallback_sw_path = false;
>> > +        } else {
>> > +            hw_job->fallback_sw_path = true;
>> > +            /* Set output length less than page size to reduce
>> decompression */
>> > +            multifd_qpl_prepare_comp_job(qpl->sw_job, buf, size, zbuf,
>> > +                                         size - 1);
>> > +            if (qpl_execute_job(qpl->sw_job) == QPL_STS_OK) {
>> > +                hw_job->sw_output = zbuf;
>> > +                hw_job->sw_output_len = qpl->sw_job->total_out;
>> > +            } else {
>> > +                hw_job->sw_output = buf;
>> > +                hw_job->sw_output_len = size;
>> > +            }
>> 
>> Hmm, these look a bit cumbersome, would it work if we moved the fallback
>> qpl_execute_job() down into the other loop? We could then avoid the
>> extra fields. Something like:
>> 
>> static void multifd_qpl_compress_pages(MultiFDSendParams *p)
>> {
>>     QplData *qpl = p->compress_data;
>>     MultiFDPages_t *pages = p->pages;
>>     uint32_t out_size, size = p->page_size;
>>     uint8_t *buf, *zbuf;
>> 
>>     /*
>>      * Set output length to less than the page size to force the job to
>>      * fail in case it compresses to a larger size. We'll send that page
>>      * without compression to skip the decompression operation on the
>>      * destination.
>>      */
>>     out_size = size - 1;
>> 
>>     for (int i = 0; i < pages->normal_num; i++) {
>>         QplHwJob *hw_job = &qpl->hw_jobs[i];
>> 
>>         hw_job->fallback_sw_path = false;
>>         buf = pages->block->host + pages->offset[i];
>>         zbuf = qpl->zbuf + (size * i);
>> 
>>         multifd_qpl_prepare_comp_job(hw_job->job, buf, size, zbuf,
>> out_size);
>> 
>>         if (!multifd_qpl_submit_job(hw_job->job)) {
>>             hw_job->fallback_sw_path = true;
>>         }
>>     }
>> 
>>     for (int i = 0; i < pages->normal_num; i++) {
>>         QplHwJob *hw_job = &qpl->hw_jobs[i];
>>         qpl_job *job;
>> 
>>         buf = pages->block->host + pages->offset[i];
>>         zbuf = qpl->zbuf + (size * i);
>> 
>>         if (hw_job->fallback_sw_path) {
>>             job = qpl->sw_job;
>>             multifd_qpl_prepare_comp_job(job, buf, size, zbuf, out_size);
>>             ret = qpl_execute_job(job);
>>         } else {
>>             job = hw_job->job;
>>             ret = qpl_wait_job(job);
>>         }
>> 
>>         if (ret == QPL_STS_OK) {
>>             multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
>>         } else {
>>             multifd_qpl_fill_packet(i, p, buf, size);
>>         }
>>     }
>> }
>
> Very thanks for the reference code, I have test the code and the performance is not good.
> When the work queue is full, after a hardware job fails to be submitted, the subsequent
> job submission will most likely fail as well. so my idea is to use software job execution
> instead immediately, but all subsequent jobs will still give priority to hardware path. 

So let me see if I get this, you're saying that going with the sw path
immediately after a hw path failure is beneficial because the time it
takes to call the sw path serves as a backoff time for the hw path?

Do you have an idea on the time difference of waiting for sw path
vs. introducing a delay to multifd_qpl_submit_job()? Aren't we leaving
performance on the table by going with a much slower sw path instead of
waiting for the queues to open up? Or some other strategy, such as going
once again over the not-submitted pages.

I understand there's a tradeoff here between your effort to investigate
these things and the amount of performance to be had, so feel free to
leave this question unanswered. We could choose to simply document this
with a comment:

    if (multifd_qpl_submit_job(hw_job->job)) {
        hw_job->fallback_sw_path = false;
        continue;
    }

    /* 
     * The IAA work queue is full, any immediate subsequent job
     * submission is likely to fail, sending the page via the QPL
     * software path at this point gives us a better chance of
     * finding the queue open for the next pages.
     */
    hw_job->fallback_sw_path = true;
    ...

> There is almost no overhead in job submission because Intel uses the new "enqcmd" instruction,
> which allows the user program to submit the job directly to the hardware.
>
> According to the implementation of the reference code, when a job fails to be submitted, there 
> is a high probability that "ALL" subsequent jobs will fail to be submitted and then use software
> compression, resulting in the IAA hardware not being fully utilized.
>
> For 4 Channel, 1 IAA device test case, using the reference code will reduce IAA throughput 
> from 3.4GBps to 2.2GBps, thus affecting live migration performance.(total time from 14s to 18s)
>

