Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B556CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnjd-0008NB-5Z; Fri, 31 Oct 2025 07:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnjL-00086e-GO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vEnj5-0006Fz-GY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761911717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXAp7rR15QP0gduGGdZPo7sGZHP/FD3T8yTrR5cnEaY=;
 b=LZngYZHq5767vZXeLsmv7Q+p2XT5RDyQDwjbaP3N1xvRIc8bsuM9c4Or4xizAHJiA1Hq0D
 Zst08VommYpSpywEkODEfmM431fSVwSReJCVObhPIpW2QrcQmMEZpDB76lBeZAB0kJM13D
 fT8Ts7m/X2Zf6Vi3PaB0I92j7ERVK7k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-OtJQn0sFPrGh1xBcdtTCoA-1; Fri, 31 Oct 2025 07:55:14 -0400
X-MC-Unique: OtJQn0sFPrGh1xBcdtTCoA-1
X-Mimecast-MFC-AGG-ID: OtJQn0sFPrGh1xBcdtTCoA_1761911713
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b4635c413a7so228337466b.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911713; x=1762516513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LXAp7rR15QP0gduGGdZPo7sGZHP/FD3T8yTrR5cnEaY=;
 b=CXnlwRqaitGjB3rE31tThfqs/pI9cLRKbQs9wpzQnI3HFTlEJA0iQwGi7DehKH+Iv1
 fGwoIqdf13P48I1hL23hKNdruj1lH4oBkyFmeEf1CAPOg+CHmw0tDKMJQHy9uqnppntU
 a+jNcnALaa5P6Zuc6YR79fR88w0nRVcPl0mmiwRKJIfa56U3zZs9agJ5cx7N8pmyepus
 otMv23BOkENVo//t+X55nG2E2H5ku4AkG7YnvaE0Mi06YbwNABOVuSIArxhl54lM3Dcz
 b5Epf9osRlSRuHwtOlWrpV7qo96q9roLlxXSk/xMjy2z+NQkH4Eg2f/knJwYcf9p1BfC
 u7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWwrJMkWc6nTEHMTpE+aD8kkh8Bb8tkwwps4nGWNT6LriLMdO0oCwjZEE/1xPLSGWXV7x6CklgddA7@nongnu.org
X-Gm-Message-State: AOJu0YxMml9Bb3Oz3Vm6Ol3NcijGV8DFcE18c/K2TnYSK6qpCD8DOHaL
 RPZJGFUMIL7wJtlwutLnYD67S9PfpWrXIKW1w2VLKnwcFMRTwI2+tl2jFKNua88NWHfUyokvrh3
 al0iuYvGp37MDz1KNG2Q12p5EQPkbaCv2snQotNopjiTA4x7NY8YqxvwSR032/KHU
X-Gm-Gg: ASbGnctSzHDtvYPDUqHRdL71LSTBi0IOMBUWYTBexa5uAtQf9CR1t/X4O/rFYl0DnfS
 4/WRZDZZJnnEV381gx+ImdvxTDwR6OpD3g6LwGTgGgo1A1LRUT26Y3VhwDFLeE6pKV1uxqlwFyy
 uTBt64oKmkelIwn6rUh9nkdi/w69j1jc60IpkCkuYGm9XjCWNQqJcw4c023HK3AjM/HgNIkGmlL
 nVQEX9uOX4TikUQ0zBg2AE8bE77su4EG9EfK/UBxsOGpF6Bx8Ev52eVz4CE8oc0y9YoK9FpZBSU
 k5q781m6gSmJUwNfBT8PIzdeF9PJnXTeHUTRC9HrLVV98RA8BxhmL1iCnVEUQA12d0iUjGrtQiG
 yisDuXJYZuZSW/6ts0R6Mx/AaNcGJPcOelncjOGX/Tw/rPu2JXTsT5TY3CbkA5c6UCxBfiD/C9V
 YFEsOnnqNZA7swCiVLN0k8t+VfMmIv
X-Received: by 2002:a17:907:7ba3:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b70708a4a35mr334563866b.56.1761911712746; 
 Fri, 31 Oct 2025 04:55:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7cro+peGjS7U5r7l+tIZnaEu2CWPRn2T3zp8lLEu8lf76Pfe3kfIwgxx+h+NVoRd9ICGZyg==
X-Received: by 2002:a17:907:7ba3:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b70708a4a35mr334561366b.56.1761911712267; 
 Fri, 31 Oct 2025 04:55:12 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b70779aa9f4sm162269366b.20.2025.10.31.04.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 04:55:11 -0700 (PDT)
Message-ID: <eff0fe4a-b49b-4f64-99b1-2eafacfb60c7@redhat.com>
Date: Fri, 31 Oct 2025 12:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/21] fuse: Manually process requests (without libfuse)
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-14-hreitz@redhat.com> <aPjLywlk8LyerNna@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aPjLywlk8LyerNna@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22.10.25 14:19, Kevin Wolf wrote:
> Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
>> Manually read requests from the /dev/fuse FD and process them, without
>> using libfuse.  This allows us to safely add parallel request processing
>> in coroutines later, without having to worry about libfuse internals.
>> (Technically, we already have exactly that problem with
>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
>> [...]
>> +/**
>> + * Write a FUSE response to the given @fd, using a single buffer consecutively
>> + * containing both the response header and data: Initialize *out_hdr, and write
>> + * it plus @response_data_length consecutive bytes to @fd.
>> + *
>> + * @fd: FUSE file descriptor
>> + * @req_id: Corresponding request ID
>> + * @out_hdr: Pointer to buffer that will hold the output header, and
>> + *           additionally already contains @response_data_length data bytes
>> + *           starting at *out_hdr + 1.
>> + * @err: Error code (-errno, or 0 in case of success)
>> + * @response_data_length: Length of data to return (following *out_hdr)
>> + */
>> +static int fuse_write_response(int fd, uint32_t req_id,
>> +                               struct fuse_out_header *out_hdr, int err,
>> +                               size_t response_data_length)
>> +{
>> +    void *write_ptr = out_hdr;
>> +    size_t to_write = sizeof(*out_hdr) + response_data_length;
>> +    ssize_t ret;
>> +
>> +    *out_hdr = (struct fuse_out_header) {
>> +        .len = to_write,
>> +        .error = err,
>> +        .unique = req_id,
>> +    };
>> +
>> +    while (true) {
>> +        ret = RETRY_ON_EINTR(write(fd, write_ptr, to_write));
>> +        if (ret < 0) {
>> +            ret = -errno;
>> +            error_report("Failed to write to FUSE device: %s", strerror(-ret));
>> +            return ret;
>> +        } else {
>> +            to_write -= ret;
>> +            if (to_write > 0) {
>> +                write_ptr += ret;
>> +            } else {
>> +                return 0; /* success */
>> +            }
>> +        }
>> +    }
>> +}
> Two thoughts on this one:
>
> This looks like essentially a reimplementation of qemu_write_full(),
> except that it doesn't count how many bytes were successfully written
> until the error happened. Is this sufficiently different to exist?
>
> And do we even need to consider short writes? I would be surprised if
> FUSE let that happen. libfuse doesn't seem to consider it an option, it
> just calls writev() once in fuse_write_msg_dev(). And indeed, the kernel
> returns either an error or the full byte count in fuse_dev_do_write().

Handling short writes adds complexity, but not really runtime cost. So 
I’d be happy to use the existing qemu_write_full(), but if there’s no 
equivalent for writev(), then that’s not really a general option.

I don’t handle short reads on purpose, so you’re right, it doesn’t make 
sense to handle short writes either.

>> +/**
>> + * Write a FUSE response to the given @fd, using separate buffers for the
>> + * response header and data: Initialize *out_hdr, and write it plus the data in
>> + * *buf to @fd.
>> + *
>> + * In contrast to fuse_write_response(), this function cannot return errors, and
>> + * will always return success (error code 0).
>> + *
>> + * @fd: FUSE file descriptor
>> + * @req_id: Corresponding request ID
>> + * @out_hdr: Pointer to buffer that will hold the output header
>> + * @buf: Pointer to response data
>> + * @buflen: Length of response data
>> + */
>> +static int fuse_write_buf_response(int fd, uint32_t req_id,
>> +                                   struct fuse_out_header *out_hdr,
>> +                                   const void *buf, size_t buflen)
>> +{
>> +    struct iovec iov[2] = {
>> +        { out_hdr, sizeof(*out_hdr) },
>> +        { (void *)buf, buflen },
>> +    };
>> +    struct iovec *iovp = iov;
>> +    unsigned iov_count = ARRAY_SIZE(iov);
>> +    size_t to_write = sizeof(*out_hdr) + buflen;
>> +    ssize_t ret;
>> +
>> +    *out_hdr = (struct fuse_out_header) {
>> +        .len = to_write,
>> +        .unique = req_id,
>> +    };
>> +
>> +    while (true) {
>> +        ret = RETRY_ON_EINTR(writev(fd, iovp, iov_count));
>> +        if (ret < 0) {
>> +            ret = -errno;
>> +            error_report("Failed to write to FUSE device: %s", strerror(-ret));
>> +            return ret;
>> +        } else {
>> +            to_write -= ret;
>> +            if (to_write > 0) {
>> +                iov_discard_front(&iovp, &iov_count, ret);
>> +            } else {
>> +                return 0; /* success */
>> +            }
>> +        }
>> +    }
>> +}
> Same question as above (except that a qemu_writev_full() doesn't exist
> yet if we decided that for some reason short writes really are a
> concern).
>
>> +/*
>> + * For use in fuse_process_request():
>> + * Returns a pointer to the parameter object for the given operation (inside of
>> + * export->request_buf, which is assumed to hold a fuse_in_header first).
>> + * Verifies that the object is complete (export->request_buf is large enough to
>> + * hold it in one piece, and the request length includes the whole object).
>> + *
>> + * Note that export->request_buf may be overwritten after polling, so the
>> + * returned pointer must not be used across a function that may poll!
>> + */
>> +#define FUSE_IN_OP_STRUCT(op_name, export) \
>> +    ({ \
>> +        const struct fuse_in_header *__in_hdr = \
>> +            (const struct fuse_in_header *)(export)->request_buf; \
>> +        const struct fuse_##op_name##_in *__in = \
>> +            (const struct fuse_##op_name##_in *)(__in_hdr + 1); \
>> +        const size_t __param_len = sizeof(*__in_hdr) + sizeof(*__in); \
>> +        uint32_t __req_len; \
>> +        \
>> +        QEMU_BUILD_BUG_ON(sizeof((export)->request_buf) < __param_len); \
>> +        \
>> +        __req_len = __in_hdr->len; \
>> +        if (__req_len < __param_len) { \
>> +            warn_report("FUSE request truncated (%" PRIu32 " < %zu)", \
>> +                        __req_len, __param_len); \
>> +            ret = -EINVAL; \
>> +            break; \
>> +        } \
>> +        __in; \
>> +    })
>> +
>> +/*
>> + * For use in fuse_process_request():
>> + * Returns a pointer to the return object for the given operation (inside of
>> + * out_buf, which is assumed to hold a fuse_out_header first).
>> + * Verifies that out_buf is large enough to hold the whole object.
>> + *
>> + * (out_buf should be a char[] array.)
>> + */
>> +#define FUSE_OUT_OP_STRUCT(op_name, out_buf) \
>> +    ({ \
>> +        struct fuse_out_header *__out_hdr = \
>> +            (struct fuse_out_header *)(out_buf); \
>> +        struct fuse_##op_name##_out *__out = \
>> +            (struct fuse_##op_name##_out *)(__out_hdr + 1); \
>> +        \
>> +        QEMU_BUILD_BUG_ON(sizeof(*__out_hdr) + sizeof(*__out) > \
>> +                          sizeof(out_buf)); \
>> +        \
>> +        __out; \
>> +    })
>> +
>> +/**
>> + * Process a FUSE request, incl. writing the response.
>> + *
>> + * Note that polling in any request-processing function can lead to a nested
>> + * read_from_fuse_fd() call, which will overwrite the contents of
>> + * exp->request_buf.  Anything that takes a buffer needs to take care that the
>> + * content is copied before potentially polling.
>> + */
>> +static void fuse_process_request(FuseExport *exp)
>> +{
>> +    uint32_t opcode;
>> +    uint64_t req_id;
>> +    /*
>> +     * Return buffer.  Must be large enough to hold all return headers, but does
>> +     * not include space for data returned by read requests.
>> +     * (FUSE_IN_OP_STRUCT() verifies at compile time that out_buf is indeed
>> +     * large enough.)
>> +     */
>> +    char out_buf[sizeof(struct fuse_out_header) +
>> +                 MAX_CONST(sizeof(struct fuse_init_out),
>> +                 MAX_CONST(sizeof(struct fuse_open_out),
>> +                 MAX_CONST(sizeof(struct fuse_attr_out),
>> +                 MAX_CONST(sizeof(struct fuse_write_out),
>> +                           sizeof(struct fuse_lseek_out)))))];
> This and the macros above are a little ugly.

It’s OK and appropriate to call them “*very* ugly”.

> Can't we just define a type
> for this? Something like this:
>
> struct {
>      struct fuse_out_header header;
>      union {
>          struct fuse_init_out init;
>          struct fuse_open_out open;
>          struct fuse_attr_out attr;
>          struct fuse_write_out write;
>          struct fuse_lseek_out lseek;
>      };
> };

Don’t know why I didn’t think of this.  Absolutely!

> And then have a variable of that type here. Instead of
> FUSE_OUT_OP_STRUCT(), you can now just access the union members.
>
> For FUSE_IN_OP_STRUCT(), there's the additional length check that you
> have, so maybe for that one, the macro still has its use.
>
>> +    struct fuse_out_header *out_hdr = (struct fuse_out_header *)out_buf;
>> +    /* For read requests: Data to be returned */
>> +    void *out_data_buffer = NULL;
>> +    ssize_t ret;
>> +
>> +    /* Limit scope to ensure pointer is no longer used after polling */
>> +    {
>> +        const struct fuse_in_header *in_hdr =
>> +            (const struct fuse_in_header *)exp->request_buf;
>> +
>> +        opcode = in_hdr->opcode;
>> +        req_id = in_hdr->unique;
>> +    }
>> +
>> +    switch (opcode) {
>> +    case FUSE_INIT: {
>> +        const struct fuse_init_in *in = FUSE_IN_OP_STRUCT(init, exp);
>> +        ret = fuse_init(exp, FUSE_OUT_OP_STRUCT(init, out_buf),
>> +                        in->max_readahead, in->flags);
>> +        break;
>> +    }
>> +
>> +    case FUSE_OPEN:
>> +        ret = fuse_open(exp, FUSE_OUT_OP_STRUCT(open, out_buf));
>> +        break;
>> +
>> +    case FUSE_RELEASE:
>> +        ret = 0;
>> +        break;
>> +
>> +    case FUSE_LOOKUP:
>> +        ret = -ENOENT; /* There is no node but the root node */
>> +        break;
>> +
>> +    case FUSE_GETATTR:
>> +        ret = fuse_getattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf));
>> +        break;
>> +
>> +    case FUSE_SETATTR: {
>> +        const struct fuse_setattr_in *in = FUSE_IN_OP_STRUCT(setattr, exp);
>> +        ret = fuse_setattr(exp, FUSE_OUT_OP_STRUCT(attr, out_buf),
>> +                           in->valid, in->size, in->mode, in->uid, in->gid);
>> +        break;
>> +    }
>> +
>> +    case FUSE_READ: {
>> +        const struct fuse_read_in *in = FUSE_IN_OP_STRUCT(read, exp);
>> +        ret = fuse_read(exp, &out_data_buffer, in->offset, in->size);
>> +        break;
>> +    }
>> +
>> +    case FUSE_WRITE: {
>> +        const struct fuse_write_in *in = FUSE_IN_OP_STRUCT(write, exp);
>> +        uint32_t req_len;
>> +
>> +        req_len = ((const struct fuse_in_header *)exp->request_buf)->len;
> Hm, was that the idea when you limited the in_hdr scope above? :-)

Well, it doesn’t break the condition but it would require justification 
here.  Probably I should just get the request length in the limited 
scope above.

>> +        if (unlikely(req_len < sizeof(struct fuse_in_header) + sizeof(*in) +
>> +                               in->size)) {
>> +            warn_report("FUSE WRITE truncated; received %zu bytes of %" PRIu32,
>> +                        req_len - sizeof(struct fuse_in_header) - sizeof(*in),
>> +                        in->size);
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +
>> +        /*
>> +         * poll_fuse_fd() has checked that in_hdr->len matches the number of
>> +         * bytes read, which cannot exceed the max_write value we set
>> +         * (FUSE_MAX_WRITE_BYTES).  So we know that FUSE_MAX_WRITE_BYTES >=
>> +         * in_hdr->len >= in->size + X, so this assertion must hold.
>> +         */
>> +        assert(in->size <= FUSE_MAX_WRITE_BYTES);
>> +
>> +        /*
>> +         * Passing a pointer to `in` (i.e. the request buffer) is fine because
>> +         * fuse_write() takes care to copy its contents before potentially
>> +         * polling.
>> +         */
>> +        ret = fuse_write(exp, FUSE_OUT_OP_STRUCT(write, out_buf),
>> +                         in->offset, in->size, in + 1);
>> +        break;
>> +    }
>> +
>> +    case FUSE_FALLOCATE: {
>> +        const struct fuse_fallocate_in *in = FUSE_IN_OP_STRUCT(fallocate, exp);
>> +        ret = fuse_fallocate(exp, in->offset, in->length, in->mode);
>> +        break;
>> +    }
>> +
>> +    case FUSE_FSYNC:
>> +        ret = fuse_fsync(exp);
>> +        break;
>> +
>> +    case FUSE_FLUSH:
>> +        ret = fuse_flush(exp);
>> +        break;
>> +
>>   #ifdef CONFIG_FUSE_LSEEK
>> -    .lseek      = fuse_lseek,
>> +    case FUSE_LSEEK: {
>> +        const struct fuse_lseek_in *in = FUSE_IN_OP_STRUCT(lseek, exp);
>> +        ret = fuse_lseek(exp, FUSE_OUT_OP_STRUCT(lseek, out_buf),
>> +                         in->offset, in->whence);
>> +        break;
>> +    }
>>   #endif
>> -};
>> +
>> +    default:
>> +        ret = -ENOSYS;
>> +    }
>> +
>> +    /* Ignore errors from fuse_write*(), nothing we can do anyway */
>> +    if (out_data_buffer) {
>> +        assert(ret >= 0);
>> +        fuse_write_buf_response(exp->fuse_fd, req_id, out_hdr,
>> +                                out_data_buffer, ret);
>> +        qemu_vfree(out_data_buffer);
>> +    } else {
>> +        fuse_write_response(exp->fuse_fd, req_id, out_hdr,
>> +                            ret < 0 ? ret : 0,
>> +                            ret < 0 ? 0 : ret);
>> +    }
>> +}
> In summary, I don't really see anything wrong, but just some things that
> maybe look more complicated than strictly necessarily.

Thanks for those suggestions!

Hanna


