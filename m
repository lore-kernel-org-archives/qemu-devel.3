Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977E71061B15
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7GyV-0002ah-Si; Mon, 30 Mar 2026 14:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w7GxJ-0002LN-SR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:03:30 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1w7GxH-0001UV-DC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:03:17 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso6640876d50.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774893794; x=1775498594; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VSSej4rQP/km8NEhv3cfELxnfJmGjoS8RTsivRF4Ji8=;
 b=J+CR5QDqPMlMGeKfWNUAc+3zrNNhWJ8qlk5LbuX612I8YXdZmQHQnhGiv0iBKMemip
 8dC1A7uLG7YSQL0prDnFIZ+iIpi25JpB9IxL2skwfOJniCL930QbJM/Dz9srbjjrWwz1
 JCZeZjckjPzKhPEU8k3MxfKapG2RlFBi4CzvLtX4Z69FRM7bNlTXVGVtuTirvlC6Yipf
 gSwfrIGQHZEJEer3WDOdzRss46v0SFjupolDsjADiDO2QdnQDuoxiPXe1DqoZINTq4mB
 fTLN1GKQwMCfFqyAtu8HqjiWfZtDU8duIT5nvX6anxs08N7RhxEO8kl1r3Oselh4CRxs
 JsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774893794; x=1775498594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSSej4rQP/km8NEhv3cfELxnfJmGjoS8RTsivRF4Ji8=;
 b=OU+LxAtTJ32EekWdHAvSxM3fsDPKmSeszY9LyaJSjDMqFSAzCUk6/RXvgdtqbO6JQd
 r3k6ZSJbFsTMfosFtCTIqqUk+1uYKHcluTXaDtaCpIjU7MWXBHtKdr4Ee2pln5SQPk6g
 K/hHCMGBIYaWgrHCZZ7ndyXcl8q/ZfLEhIMv+glbG7Jj++SoXC2S9lDeOtXGeMeZJhjl
 B8GQHyOjKqbr8pKwM9EP786SRs+eU3EOr4qHItmtP+NqVQryIqKDZJOe5LmNLyd44qsJ
 V8/a/thgx7ZkNWItPrIYEbxQ4621XOmH66EbcYZO/VQY3jA8zi3RhO/EpmUCy3UUuIXK
 rbyA==
X-Gm-Message-State: AOJu0YzEuKlUKbDb2nejry/urEXUcWIeSsOw1NuuQHymoykAMNjcLWbF
 dykDn+Y0/jat5MQ6+fRnK2IJl7GaH6qIYrHqBrQHh0dHy9fFjFDZ01Bp
X-Gm-Gg: ATEYQzyVfYL2k/inRrQwEOatWGvcDk5ffaDD6oUCcqeOATcnaanv4z1OebSsnTC6HeC
 vIZ0Z+WbXPyvxRX4qu0e3QF7KOBA7YWPxBes/3z1teFScenVrCrkA04LAdbN7E7wE6fYcMX+CRA
 TxtN5GXIqrzYpw6Rdxbq0W7vrPBfSQBy5QQTs8K+EnoFWthHcC0LUfaaaGJHD3oiH68KK6FowDs
 GoIIEtLXt7qmWXo7JYPLS6/+bNi2L/qJv8yk+w5joXOK/w81iSyhNhupcOh23sxrLObyvwoCP3X
 CIsZkl6RWxXpsB+ZUFYflF9yisMn3KyOV6Gp83jhextkUto16Nd64dXLl1JO0LC+xRQIM+r04Pe
 oMbwI2107yL7YiNhaMPB8OzAit6YOzLZ8C8ndMtRTUOHUA8cEVUfhCdJZT90uUpxQbWFN3w1q37
 snNd9YWXi+PU1HY3qzvL2BqqTs1TU7AOqDl6xcv2CQrA==
X-Received: by 2002:a05:690c:6a10:b0:796:5a14:87c6 with SMTP id
 00721157ae682-79bddcd9a75mr136950247b3.4.1774893794063; 
 Mon, 30 Mar 2026 11:03:14 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79cb7135bd2sm38243927b3.2.2026.03.30.11.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:03:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 30 Mar 2026 11:03:10 -0700
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, linuxarm@huawei.com,
 lizhijian@fujitsu.com, mst@redhat.com, pbonzini@redhat.com,
 gourry@gourry.net, nifan.cxl@gmail.com, me@linux.beauty
Subject: Re: [PATCH 8/9] hw/cxl: Add tag-based dynamic-capacity release support
Message-ID: <acq63qeubIux3W0p@4470NRD-ASU.ssi.samsung.com>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-9-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325184259.366-9-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=anisa.su887@gmail.com; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 25, 2026 at 06:42:56PM +0000, Alireza Sanaee wrote:
> Add support for the tag-based dynamic-capacity release policy via the QMP
> interface. The new path scans committed extents, selects those whose stored
> tag matches the requested UUID, and emits a Release Dynamic Capacity event
> for each matching range.
> 
> This is intentionally scoped to tag-driven selection. Prescriptive release
> handling and the underlying extent teardown stay in the existing paths.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 6b73d58358..d5fa8a530a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2492,6 +2492,63 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>      cxl_create_dc_event_records_for_extents(dcd, type, extents, num_extents);
>  }
>  
> +static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
> +        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
> +        CxlDynamicCapacityExtentList *records, Error **errp)
> +{
> +    Object *obj;
> +    CXLType3Dev *dcd;
> +    CXLDCExtentList *list = NULL;
> +    CXLDCExtent *ent;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +
> +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve CXL type 3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +
> +    QemuUUID uuid_req;
> +    qemu_uuid_parse(tag, &uuid_req);
> +
> +    list = &dcd->dc.extents;
> +    size_t cap = 8, n = 0;
> +    extents = g_new0(CXLDCExtentRaw, cap);
> +    QTAILQ_FOREACH(ent, list, node) {
> +        QemuUUID uuid_ext;
> +        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
> +        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
> +            continue;
> +        }
> +
> +        if (n == cap) {
> +            cap *= 2;
> +            extents = g_renew(CXLDCExtentRaw, extents, cap);
> +        }
> +
> +        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
> +                                         .len = ent->len,
> +                                         .shared_seq = 0 };
	extents[n] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
                                       .len = ent->len,
                                       .shared_seq = 0 };
        memcpy(extents[n].tag, uuid_ext.data, 0x10);
        n++;

That should fix the issue I was talking about earlier in the other thread haha
(I tested it this time)
> +    }
> +
> +    if (n == 0) {
> +        return;
> +    }
> +    extents = g_renew(CXLDCExtentRaw, extents, n);
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
> +}
> +
>  void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
>                                    CxlExtentSelectionPolicy sel_policy,
>                                    uint8_t region, const char *tag,
> @@ -2537,6 +2594,10 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint16_t host_id,
>                                                        region, tag,
>                                                        extents, errp);
>          return;
> +    case CXL_EXTENT_REMOVAL_POLICY_TAG_BASED:
> +        qmp_cxl_process_dynamic_capacity_tag_based(path, host_id, type, region,
> +                                                   tag, extents, errp);
> +        return;
>      default:
>          error_setg(errp, "Removal policy not supported");
>          return;
> -- 
> 2.50.1 (Apple Git-155)
> 

