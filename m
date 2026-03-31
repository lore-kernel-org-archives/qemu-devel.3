Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230DA10F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cYs-0002Pj-Lh; Tue, 31 Mar 2026 13:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w7cYo-0002Od-Ex
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w7cYm-00036e-G4
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774976840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wEG7/7ib7BLy8Vy/hlPRTm091we8TR/osV1Th07AGjA=;
 b=ijHSsNZu+602z4COnwYtCA3vuRjruTq5IC2xNi+/XGpTwghDMcTjbmTIhgNpw9Ztf9eMxd
 FU/zFfbyGAr9E05xvrWa8fCY9AjnH3F8EVj8miNHWMG+HmMKMBSFkXGqseR8RQQEp+cfqF
 AOhrIgJ43XQP6rQXQ5cf1wu8JCcLqEo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-3CWGJIMsPzG5PBC2ncfOqQ-1; Tue, 31 Mar 2026 13:07:18 -0400
X-MC-Unique: 3CWGJIMsPzG5PBC2ncfOqQ-1
X-Mimecast-MFC-AGG-ID: 3CWGJIMsPzG5PBC2ncfOqQ_1774976838
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso13871666a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774976838; x=1775581638; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wEG7/7ib7BLy8Vy/hlPRTm091we8TR/osV1Th07AGjA=;
 b=pU2utzOsapEUS1QzmOik01kScZ3+VxtVYK+Vslg3A6SE+bFq8YxlPbMjt5ViNsYonN
 P6kxe49KRiSEUJJncbnYVoYKURWDlEdyha6+Q6O/TCUfnabHgfRkdnZBQ5kWq/zqshIo
 o+U26MwmOTYW67WYyHo5uTSulbc/OWewAQ9axXyDPqGBxEz0b/S4ZTwok7MHjLRROoPv
 DA/HK+x9qaF5O/DHTVUGe5gbsyiBPSn/v+MdGhwndpe7tgBlrP29c5hBTd4PnNnHgMKi
 z2QUq4OYsrbKlb6CcHnBldD0um3bJoHXlE+3vlChAKNU7NkUq9dj/7lyhBgadHOXIF/B
 pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976838; x=1775581638;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wEG7/7ib7BLy8Vy/hlPRTm091we8TR/osV1Th07AGjA=;
 b=a4tWfEBPhXC171UDSv+YUNTRCejfsqQ5WF7iRmByLQXRWULiw2YCrI84I8rrvuHnGo
 bRRITDCnQLJvbnPxMi6gsH3f8rlfhHaUdY0Vg6Wi+OpKtQQncCkPtbxalSlqIevDUnPb
 IdYpxcsq0zbryvrOQ/DXjKj8SE70xF9GBuZBdAgyYWkI+hR0v/BpfgQcClXllhNGlOIA
 qpmc7yhghOnnChOiX+3RgdGMa5QpBLPeK3kz9VXdBMMgLY75q1wzDGGOmJT6GlOyKezu
 TzvXtKSt5St26gMU4Ymhp7+MKEhjgSGa/K7C+pK77pNv2ZatGnP7msjI159stgeYPQZ6
 m3XA==
X-Gm-Message-State: AOJu0YyX8d21ZuLoPzwEqI9WUtES/dPIM/m3XiM1Tx0WdhLQTfUntvjD
 EO99JJr1CHEWpAQgiObkSl8BPMP42DIc6jWc9TYLXVWaqjGpaC94IgNKgE3CvlcfD2SspYGeyfF
 2jztFSaGioCoxgCt75w453muEFPAj3nB7z0lIqgZwXfhiTYsNb/iL8g+A
X-Gm-Gg: ATEYQzyygZPK9X5bY+TKw7YFIgpwspfa8RpZ2oZtZioYH9dOU7uWpqtj9a7E2Zo3rEf
 co5ZnmVRu02bLBF2bKH897CCGrXI2nYm4cNXN6dsiesnuwfFw+Nq05BoGdEh3ttsD4Slenu+rOE
 KDViJVQR5tqj60vwx6YRI9gR1LgayudeFmiu8h3d0Ld2ednKElI37LW8Ksmnx2z+v2Rx79OBTeW
 KpFGFWoItp/hWltEKQXdcDGIeTKkNlaQa4Jg3uChxtNSJrFelt/8OD9aE2HmcyShbAwuwWkwH+T
 YxsV+3ajESq6zFTBKI2le4umqcK/fuzUbT3NYfH+zsU0G3aAyVNAVKMAtHpvTIjTmOK7AMw/DIj
 5s03wNgorjjDE
X-Received: by 2002:a05:6a00:2e94:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82ce8949688mr409529b3a.25.1774976835069; 
 Tue, 31 Mar 2026 10:07:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e94:b0:81f:31c3:2e34 with SMTP id
 d2e1a72fcca58-82ce8949688mr409486b3a.25.1774976834395; 
 Tue, 31 Mar 2026 10:07:14 -0700 (PDT)
Received: from fedora ([49.36.108.104]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca86286dbsm11136254b3a.56.2026.03.31.10.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 10:07:13 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:37:06 +0530
From: Arun Menon <armenon@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC v2 4/7] hw/tpm: Implement TPM CRB chunking logic
Message-ID: <acv_OgPqHED_rQbq@fedora>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-5-armenon@redhat.com>
 <177452442285.34609.12928739139262714987.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177452442285.34609.12928739139262714987.b4-review@b4>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

Hi Marc-André,

Thank you for the review.

On Thu, Mar 26, 2026 at 03:27:02PM +0400, marcandre.lureau@redhat.com wrote:
> On Thu, 19 Mar 2026 19:23:13 +0530, Arun Menon <armenon@redhat.com> wrote:
> 
> Hi,
> 
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 5ea1a4a9706..e61c04aee0b 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -80,6 +82,8 @@ enum crb_ctrl_req {
> >  
> >  enum crb_start {
> >      CRB_START_INVOKE = BIT(0),
> > +    CRB_START_RESP_RETRY = BIT(1),
> 
> Hmm, maybe we should rename that field, since it is "Start" in the spec (it changed?).

The Start has not changed from before.
Yes, I shall make changes to the other 2.

> 
> > +    CRB_START_NEXT_CHUNK = BIT(2),
> >  };
> 
> And follow the spec naming here "RspRetry" -> RSP_RETRY
> 
> > @@ -122,6 +126,68 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
> > [ ... skip 23 lines ... ]
> > +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS, tpmSts, 1);
> > +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> > +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> > +            tpm_crb_clear_internal_buffers(s);
> > +            error_report("Command size '%d' less than TPM header size '%d'",
> > +                         total_request_size, TPM_HEADER_SIZE);
> 
> Use PRIu32 to avoid sign sign-mismatch

Yes. Will do.

> 
> > [ ... skip 28 lines ... ]
> > +    if (to_copy < CRB_CTRL_CMD_SIZE) {
> > +        memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> > +    }
> > +
> > +    s->response_offset += to_copy;
> > +    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> 
> Those lines are repeated below and could be factorized.

Yes, I will move it into a separate function

> 
> > @@ -152,20 +218,48 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> > [ ... skip 21 lines ... ]
> > +            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
> > +                if (!tpm_crb_append_command_request(s)) {
> > +                    break;
> > +                }
> > +                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
> > +                g_byte_array_set_size(s->response_buffer, s->be_buffer_size);
> 
> This pre-allocates the response buffer before the backend has written
> anything. Since response_buffer->len > 0 now, a subsequent nextChunk
> from the guest would enter tpm_crb_fill_command_response() and serve
> uninitialized data.
> 
> Before this patch we would serve guest input data, which wasn't great either.
> 
> 
> We could add a separate flag to track response readiness instead. This
> will need to be migrated too.

Good catch. I did not think of what happens when the guest issues a
subsequent nextChunk while the tpm backend has not yet processed the
command.

I am wondering, checking if the start invoke bit is set will alone
prevent such a situation in the first place.

For example adding the following at the beginning,

case A_CRB_CTRL_START:
    if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
        break;
    }

That way, a subsequent nextChunk or rspRetry will not be processed in
the first place. Do you see any problem with this approach? This will
also allow us to keep the migration logic as is.

> 
> > +                s->cmd = (TPMBackendCmd) {
> > +                    .in = s->command_buffer->data,
> > +                    .in_len = s->command_buffer->len,
> > +                    .out = s->response_buffer->data,
> > +                    .out_len = s->response_buffer->len,
> > +                };
> > +                tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> > +            }
> > +        } else if (val & CRB_START_NEXT_CHUNK) {
> > +            /*
> > +             * nextChunk is used both while sending and receiving data.
> > +             * To distinguish between the two, response_buffer is checked
> 
> Missing .

Will correct.

> 
> > +             * If it does not have data, then that means we have not yet
> > +             * sent the command to the tpm backend, and therefore call
> > +             * tpm_crb_append_command_request()
> > +             */
> > +            if (s->response_buffer->len > 0 &&
> > +                s->response_offset < s->response_buffer->len) {
> > +                    tpm_crb_fill_command_response(s);
> 
> Indentation <4

Yes.

> 
> > +            } else {
> > +                if (!tpm_crb_append_command_request(s)) {
> > +                    break;
> > +                }
> > +            }
> > +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
> > +        } else if (val & CRB_START_RESP_RETRY) {
> > +            if (s->response_buffer->len > 0) {
> 
> I'd suggest adding a trace here.

Sure, will add.

> 
> > @@ -205,13 +299,36 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
> > [ ... skip 15 lines ... ]
> > +
> > +        /*
> > +         * Send the first chunk. Subsequent chunks will be sent using
> > +         * tpm_crb_fill_command_response()
> > +         */
> > +        uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, s->response_buffer->len);
> 
> QEMU coding style: declaration not mixed with statements.

I will add this to the top of the block.

> 
> > +        memcpy(mem, s->response_buffer->data, to_copy);
> > +
> > +        if (to_copy < CRB_CTRL_CMD_SIZE) {
> > +            memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
> > +        }
> > +        s->response_offset += to_copy;
> >      }
> >      memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> 
> Consider factorizing
> 
> > +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
> 
> redundant clear

yes, shall remove.

> 
> -- 
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 

Regards,
Arun Menon


