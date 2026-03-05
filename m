Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B65F47CDB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyG0i-0005l3-Ti; Thu, 05 Mar 2026 16:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyG0g-0005kk-GG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:13:30 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyG0e-0000zS-TX
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:13:30 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-8cb38e6d164so1103297285a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772745207; x=1773350007; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AuIW6rUe9wDJjgI+kdtGhlvZPZcNSMX7nz6lR1Qg9lQ=;
 b=DeIqBvDL2MEHQMFVFfJxOmxvkUOCDh9a1q/whZxovFfgjn+sn7M3SSfihlx5hg/Oz9
 lVeussDIYd7UljKm54O2idPuIn48jX5ZuQC+64Ft7qrXvblp0IpPFhwUjdpJjeLzm2Ry
 zRCV65QBJkeaAHJhVO+CvZqpQ5XH02Kiy3vlCQ6leNhONKKY5A3x/FzbzumgLjWCHCFf
 Uz6cB+8BtjmU/L15yXg8NkRk43jK8cadPU0cTWRVr5XCplaGT4kZ4E7Fe63IoD23zgHQ
 WkMtwSQlx1ChRmmFxKHCUBpXxgV9/Z36nDilWb0NmPBfsZvotlojMIvNBFq8YCMljdqR
 eAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772745207; x=1773350007;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AuIW6rUe9wDJjgI+kdtGhlvZPZcNSMX7nz6lR1Qg9lQ=;
 b=YtYnUS727Bvq1de1IXMhOdEO7ewav9mfVmigeskhw2VclPvsu61gagVz9rZhWqqEUS
 RWi0y8BKmVRAM3Zkut5Ecm1rriSkKB9eXzIqDIl3I43L/7Mt0pPcwvD87305HOQyk/q3
 8773GqFa7iND9IUaFqTRi45k5FGFG/gCQceJNBqr8GmZ1ItdXadHt06wHOoB9e01oUZH
 Tmbf1rPu6NU9qHBaITLlXqydBef+qQJVxKaGFUdnvKhMxW6qJ8Gp1MIODf1dn8uKLBRz
 kpAUgmjXNW2ir7ELdH12p9or720neo27ioOl4ZBwr0Xuj/mKMZgiojAMhFx5TMby1BTo
 rgSw==
X-Gm-Message-State: AOJu0YzCFK/OUxYVLwDNrk8ybOCYvs1WpjS/FiQ6I95AUfFoRHmdcA/N
 lEUPqk9aVykGGJlWdbFusfwk+xh5U7n72sVrblNnnwDGkW/eKfQIxDxLaUCqxLhJcik=
X-Gm-Gg: ATEYQzxitTROxRqY2kcyztYW1DugmleqkC0PrkocYzUxfRLeK/+sV1NnRyHwsX3pPOl
 l5FhWZZ7YvMV3gKSo7z/fikRz/cLPExVoYyHZj42fLEYm4WJxZn8HipR9IY1uszbGgl6Pnsgcq6
 AV+rkaU+FLmhEtm0vipLQJSRLaCdq8P6yWONoT2jdNBuXUipELXxgyyxgs9DzlUKNm1xVjdAtrT
 zOjTtAQ8hk8f1/b2Qosu9cY6VeDFJoUDlQY3/7SnXzXxWKjQSrUkFxAlLh7aPW2NnpAidWwocvN
 9C3RcHXrDitbkM2/FN+WH3aTBwzTXmx4QJWCDgoU3WwdqFdL7J7EGNPiHU+I7vSnrW4lDqEDwlP
 0Loinoh2Pd3HM/lSkY1ER8bMxXmxSUpRe/VZEI0iVPDJV9weAx30CcDZq/CzHeXAu36NFxQUAq7
 0i81kpcFv9KRYsrdZMprbZn8ATxaSaHlTCgTvJzr9clJF77BQWd3vCzwk53exjee3G+k0gs1kfj
 HRiwaMlJA==
X-Received: by 2002:a05:622a:1917:b0:506:4141:48b0 with SMTP id
 d75a77b69052e-508db290abemr97368401cf.18.1772745207481; 
 Thu, 05 Mar 2026 13:13:27 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744ad8f8bsm188735781cf.27.2026.03.05.13.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:13:26 -0800 (PST)
Date: Thu, 5 Mar 2026 16:13:24 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, anisa.su887@gmail.com,
 armbru@redhat.com, david@kernel.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 ppbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v6 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <aanx9AVMvca5n2yY@gourry-fedora-PF4VCD3F>
References: <20260226152034.1523-1-alireza.sanaee@huawei.com>
 <20260226152034.1523-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226152034.1523-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=gourry@gourry.net; helo=mail-qk1-x731.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 26, 2026 at 03:20:34PM +0000, Alireza Sanaee wrote:
> +        /*
> +         * Optimization: Looking for a fully committed path; if the type 3 HDM
> +         * decoder is not commmitted, it cannot lie on such a path.
                               ^^^ committed

... snip ...
> +                object_child_foreach_recursive(object_get_root(),
> +                                               cxl_fmws_direct_passthrough,
> +                                               &state);
> +            }
> +        }
> +        dpa_base += decoder_size / cxl_interleave_ways_dec(iw, &error_fatal);
> +    }
> +

Div-by-0 here for invalid values?

int cxl_interleave_ways_dec(uint8_t iw_enc, Error **errp)
{
    switch (iw_enc) {
    ... snip ...
    default:
        error_setg(errp, "Encoded interleave ways: %d not supported", iw_enc);
        return 0;
    }
}

Or does this abort before return?

> +    return false;
> +}

You're returning false as an 'int'

~Gregory

