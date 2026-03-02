Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454ABEB3633
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9Yv-00038G-S2; Mon, 02 Mar 2026 15:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9Ys-00037U-9x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9Yp-0007Gg-Nr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772482087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eDCTxDJHPh28Eoz4wwDdEqPshwFc8Qm4f7/nAu0q65k=;
 b=XdPYGXz6y0hSnUJXYUCXgKj3FsO6cX9JmtFpbAcloE916zYShbGPuu/lBoahyQOmUQw7Ib
 wv2f7s7B2M/yt1QaNUiR5+Jn4ShfU23xinD/fDx4n/WRMilpXLM7HkObaPAQ8OnTjqo30e
 ECBy3W5yzG4LwG8AhDsI8wXyOjim7iM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-fwXSB5GaPRWEDO-gEcI8ag-1; Mon, 02 Mar 2026 15:08:06 -0500
X-MC-Unique: fwXSB5GaPRWEDO-gEcI8ag-1
X-Mimecast-MFC-AGG-ID: fwXSB5GaPRWEDO-gEcI8ag_1772482086
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-506b4005ab7so601264551cf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772482086; x=1773086886; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eDCTxDJHPh28Eoz4wwDdEqPshwFc8Qm4f7/nAu0q65k=;
 b=XWHq1Tic8O1c/hf6+uWLupIe00owVqLT0os5a0tnytGVPhV7cpNNaYPyGmxi0VHpSv
 AxvI+ooUuMxb56jQcZ/7zAZq1rlK+aIjwOl54dmrdfW5oJ6K3aIWAUMzN4WMkgGSmaXC
 Tp29BiGh+s9yhiiKOH8XZEk+kxHvUaTCpvIGZndYZzFhT9LEudCJIMmMGEFeXFirAc+5
 6sWnPoo9sOraR6xzRPld/aDJlVy6EOjeezBZy/7uTP4SQ78YJKtybiJZcVExuZd9aD2z
 lsFCqwxpYaOINmJZu8/0Nclf8POiaB/23+dXCHXD6Dq9P0vvnq0tqcl7lolh2AM4twIy
 Q5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772482086; x=1773086886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eDCTxDJHPh28Eoz4wwDdEqPshwFc8Qm4f7/nAu0q65k=;
 b=Nir3uLWLDQiDRylzHK3QE2lLZzJsFQe6KQdbBMsPII3ZtM6PAownNHB0jXE4xJ0eYI
 nFkw77P65zRE4lWLD4eoxKzinyk0eJ6C1ctWqGyQEVHDTpL415+vQTojk4SCXxOhh97G
 /khyY+chkKnSAFu+tEOIhHh+hobJeDVH2kgU2rlx/EukQ8Ps5QcMcKNFOp2Mr5znj8hl
 Vd2QB0YPX2Yk7FWV0ZSXuI3B6kRng8xLTscImlR420SmYr58r/dXh7vCJk2zX7Qz1Fu3
 +DREfpBv2iUfugRmxdu0gs7Wls3xWp9rCqQfGXFz7OAY37Cv1VfOhGqc5XxKIdsgXHNo
 wZGg==
X-Gm-Message-State: AOJu0YyuuJp65mLnZWNsdnYIvTdVDHEEuwSERgw95bCmHKaP8vE2kdsJ
 fXywkcJuGzjzK9DZaKMzZhJYdtITsEGCE84MZdXBY7SdqDcH3xOAAO2lYVlF9Obm394rQkg6/v0
 STWeGYOCkpAoGiOD6fPFpx+ScbA+hHsmwJlzvr9AsrRLDiGcKPsZ5SOjL
X-Gm-Gg: ATEYQzwtPLkZtYVx56CM3G+I6bq3PkCqMyMxVuCW9OagG7lbNcaektM58NJoShMCEF8
 KQOxVquciAl2lDcU7KXYHAhO/ysh2BrbuM3m5Cuijx0KY7AmLKcOcp9eLYAhm66Q60hH6h7Y9Gz
 KUd/d9fl7WTBovQ4YuFcETHWeoSUXQ0A1m+p8ghUey6sptdeDTKk0sR/Q3qw57g3X6fypdtlif8
 DtbiEQuNqtAea72tp8szDX9hCUL7HQKlI2we/P/yzg3/LX5Xoy6FewOYLOPjUjEqH8m1QIxx2qq
 YWDeNIKDFnWpmX5Z7Y+lS4iNQ3q2+FfI8gSfltYvltRS8hB4T6TpisV3d59BgYWOrnfTcoM4AB2
 UVjEBgUCoky0p2g==
X-Received: by 2002:ac8:59d4:0:b0:4ed:de14:b374 with SMTP id
 d75a77b69052e-50752a1ccebmr187952751cf.64.1772482085849; 
 Mon, 02 Mar 2026 12:08:05 -0800 (PST)
X-Received: by 2002:ac8:59d4:0:b0:4ed:de14:b374 with SMTP id
 d75a77b69052e-50752a1ccebmr187952351cf.64.1772482085433; 
 Mon, 02 Mar 2026 12:08:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744afbba3sm128290381cf.33.2026.03.02.12.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:08:04 -0800 (PST)
Date: Mon, 2 Mar 2026 15:07:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH v11 20/21] migration: Keep s->rp_state.from_dst_file open
 until migration ends
Message-ID: <aaXuGQPX6vQkNBJV@x1.local>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
 <20260302-colo_unit_test_multifd-v11-20-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302-colo_unit_test_multifd-v11-20-d653fb3b1d80@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On Mon, Mar 02, 2026 at 12:45:35PM +0100, Lukas Straub wrote:
> This will be used in the next patch to allow COLO to reuse the return path.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


