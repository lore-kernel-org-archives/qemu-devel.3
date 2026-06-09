Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725B8CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvIW-000557-0M; Tue, 09 Jun 2026 08:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWvIT-00051R-5e
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:11:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWvIR-0001Mt-Cc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:11:08 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659BnPbZ2533143
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 12:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OEhCqF6bRLmNbQmPYoolDZg8w3hx8Ppa5cIBxnlYNrI=; b=Bq0jYDfsm9LFIXQE
 QIQiQfvjCXZwUoRsINKQOkdJzjCe8wIB9I75Lz0h7FHqm5x5p1Zga8NQZwWji9Ql
 S3DJef6Z5lWGkiN8Aga3G4ICvL41nlLKcEVogMV/J6g+H4L0G/p6zBIel2fZJItv
 ssWJqTJ8mkGbUtXrkHjXzYNZnVcyH1/b1Rav+PUcRTAohATsNWEt+xLNKWtieiRW
 0XHjk992esymzobU5eY6xLQWPMZRPxwURQobiCTI79DE5vhVfsOApxBCVZMGSBgp
 L1KrITWGMoir3/jaINX5neXF7EeRBEp1VoDsNO3Ob17C0+JscbyaAAoaP/JGGptc
 y+w0Pw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25s87c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:11:05 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7002d6c3426so4904887137.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781007065; x=1781611865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OEhCqF6bRLmNbQmPYoolDZg8w3hx8Ppa5cIBxnlYNrI=;
 b=ORmiTSxaiJHhwkrWSbtKsdZh+N8rQFDbnYKkshQ9j0EdDq9QkgSXW1WZPlfujSTOvm
 jxLUeGYNo7Y52t7eCGot0+DOshcTiQAgrvP59J6Aj4PsR5YW3CaaB7LRbkf26+GtvDNW
 vpKwqhoYfeAf3B4OvEIHyokyX+Xmt8o+79kejdj7e1NRZVdGNvoD+YMShV5rjEUEqlop
 DeULacxQ0PYj1cv4PC6XnR4MaY8TJBqeVOPhCXmLjS3VFfoSyHGpNBPZPMJhgf84+U/M
 wvFaEk8aaQop+fgjvFHNyr4kGuh2q/t2q9N8u4Ds0MtD/vQl2RnFDcgLwpvRG+XvF0A3
 utGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007065; x=1781611865;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OEhCqF6bRLmNbQmPYoolDZg8w3hx8Ppa5cIBxnlYNrI=;
 b=nHqmS32984RrgJccs4Pc12MuPvBP5MRz/eyZXq5AroX6Acss6ZdTpHkSVdOJfqh+Ii
 Zb2BwruLwKb7sH/mXAYMUjJGE6hGR8jNeHUkvEyPAfHXSBNmo1gJ8WsWq/HjH46BYc4T
 +MREKvrJqnAJXnIdG7waN5ybzHbDdJw7DZIrSKz6UmoovjCC3S7eeCrzDEBx9hTtN0Dz
 quLehpamcSKN/0DNQHlAQCvaFgJ9PvUD8RHpOYQecxmfKP0ChIPVPibXeozZFmY/1ZWb
 KzfC2BA5zbjERQhFDeYTwynE//7VaqwsZLINoB8UF+cj1FqX8MxNUuFgJlSwkQyg5M/T
 a8tg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SvjKI5WexA3ns7CvzmWlt4p1lk+2vVT5vUmXFsda39aTqKexnDZ3IzHlajdMKErjLIDF4311QoNd+@nongnu.org
X-Gm-Message-State: AOJu0YwuFSwBTPgnjaqEozacSOh4VmISrAHUxmK4GLJH5945+r3xnhux
 qVQkJByCW+/8OJjjqPQxiwNVK6Qy7L8kRTyhKjUZrl3hPLCmOhr+P/o2H9p4QYGNiLZr0hi63Zw
 Uvp0UL+5r1ZiCphRxP2duvHO5Rf1aD0mhmGMwuhbVTiqpgpDtu+1fLMdxNA==
X-Gm-Gg: Acq92OGfzb1aIyHHsXJ+Z1kYEvECb0tGDrlDIRSw0L/ZYGyYgkHHlIBmF1/m7HrVPYt
 FieC2X6FxZLsoEfDnfqr6hudXvoLyW1+BoShwhB66gUnRDj3woXRZEZS+ubWjVS0JvbJALjXTo3
 WMatPjmnev2z14XmkAWbCRTHEb4ekyUgjtyAZEOeee2quL1NyUzjsNwh5xDLf4rrdhKJWKrQpsn
 aXWcClAJn0IUfZSlD2+yBKptWS0z9Pf52C7wwtNS3hPoXirY4+5aslm0SPXBSsy2s/ehXPYksLs
 4nAYLQozJvJ15RFYkwqi9mXSCF3djKKZXvnyOOb2FLg8A2hH+rw2HLwzihdY0YOLL/iZMHcHK4+
 0yOs2d+muWQXhHXdjIfa+E3v6Bkfy8IbQG993luVCJfB3VlIykrD590pTrZ1RMg==
X-Received: by 2002:a05:6102:370f:b0:631:ec2d:12c1 with SMTP id
 ada2fe7eead31-6fefc0104f0mr9729667137.1.1781007065187; 
 Tue, 09 Jun 2026 05:11:05 -0700 (PDT)
X-Received: by 2002:a05:6102:370f:b0:631:ec2d:12c1 with SMTP id
 ada2fe7eead31-6fefc0104f0mr9729623137.1.1781007064719; 
 Tue, 09 Jun 2026 05:11:04 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6912365bd3fsm5026151a12.5.2026.06.09.05.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 05:11:03 -0700 (PDT)
Message-ID: <775738ae-3a47-4ee6-900c-56ba77b4185e@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 14:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] migration: Propagate errors in
 migration_completion_precopy()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-2-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260609075812.32067-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lepoHCaGVGN5AfiZFufI6pNCGjzU-ZIK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExNSBTYWx0ZWRfXwp+ZlNxuQD+4
 QCMDsNfg4zXpD6ZRj69ggiKp8CiDxPZGKtaodtdHDjuioMQjiqMNGsCF+/91GtzmWAoYiF83dqX
 q7xZyXIscZrdWV8nb4xismJ2TteHl9bv090bP0bisKYcHpkd8VwzRwCqjKOHDkive1Til9rRKZ7
 IlT2vRf1TO9iBGxAOa9ue0UAmhmNhVn4sjpbIE5n/EdZzKmUtA1FdOGcsef6YoEwqbZ/3GX7dVt
 RZ2jUh9usoYP5ya2aIrF915Nz6sUzZSjpGGUT8rxn3wrs+rOG+Ytf22XC6mgI0qfcLtPIh+amSs
 CYYFbRKZG1wefw0XWy21do6UDiA5Zgcds9OWcxXMOJn8igskD/4gq6JoLJMaXjpwvLltUkZGfhL
 XQ3GkBwelUIkxX4pbcE3GGiUaG/88fwCebXyqTFvxcTK8twAXlZrYyiLawSsyFhpq7WVjmxGFbM
 4vwcoXthXYZ9M0uz+Jw==
X-Proofpoint-GUID: lepoHCaGVGN5AfiZFufI6pNCGjzU-ZIK
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a2802d9 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8 a=e-TuEqqI40O9X7CSI78A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090115
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 9/6/26 09:57, Avihai Horon wrote:
> migration_completion_precopy() doesn't propagate errors to migration
> core which leads to error information loss. Fix that.
> 
> This prepares for a follow-up where migration_switchover_start() can
> fail on switchover-ack and still report a useful error.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/savevm.h    |  2 +-
>   migration/migration.c | 13 ++++++++-----
>   migration/savevm.c    | 29 +++++++++++++++++------------
>   3 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..b6bb4fa977 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -44,7 +44,7 @@ void qemu_savevm_state_header(QEMUFile *f);
>   int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>   void qemu_savevm_state_cleanup(void);
>   void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> -int qemu_savevm_state_complete_precopy(MigrationState *s);
> +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp);
>   void qemu_savevm_query_pending(MigPendingData *pending, bool exact);
>   int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
>   bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..aad23f3228 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2814,7 +2814,7 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
>       return true;
>   }
>   
> -static int migration_completion_precopy(MigrationState *s)
> +static int migration_completion_precopy(MigrationState *s, Error **errp)
>   {
>       int ret;
>   
> @@ -2823,16 +2823,17 @@ static int migration_completion_precopy(MigrationState *s)
>       if (!migrate_mode_is_cpr()) {
>           ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>           if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to stop the VM");
>               goto out_unlock;
>           }
>       }
>   
> -    if (!migration_switchover_start(s, NULL)) {
> +    if (!migration_switchover_start(s, errp)) {
>           ret = -EFAULT;

This function should now returns a boolean IMHO.

>           goto out_unlock;
>       }
>   
> -    ret = qemu_savevm_state_complete_precopy(s);
> +    ret = qemu_savevm_state_complete_precopy(s, errp);
>   out_unlock:
>       bql_unlock();
>       return ret;
> @@ -2869,7 +2870,7 @@ static void migration_completion(MigrationState *s)
>       Error *local_err = NULL;
>   
>       if (s->state == MIGRATION_STATUS_ACTIVE) {
> -        ret = migration_completion_precopy(s);
> +        ret = migration_completion_precopy(s, &local_err);
>       } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
>           migration_completion_postcopy(s);
>       } else {
> @@ -2900,7 +2901,9 @@ static void migration_completion(MigrationState *s)
>       return;
>   
>   fail:
> -    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> +    if (local_err) {
> +        migrate_error_propagate(s, local_err);
> +    } else if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {

   if (local_err
       || qemu_file_get_error_obj(s->to_dst_file, &local_err)) {

>           migrate_error_propagate(s, local_err);
>       } else if (ret) {
>           error_setg_errno(&local_err, -ret, "Error in migration completion");
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 23adaf9dd9..9d1d58c8f4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1771,28 +1771,34 @@ int qemu_savevm_state_non_iterable(QEMUFile *f, Error **errp)
>       return 0;
>   }
>   
> -int qemu_savevm_state_complete_precopy(MigrationState *s)
> +int qemu_savevm_state_complete_precopy(MigrationState *s, Error **errp)
>   {
> +    ERRP_GUARD();
>       QEMUFile *f = s->to_dst_file;
> -    Error *local_err = NULL;
>       int ret;
>   
>       ret = qemu_savevm_state_complete_precopy_iterable(f, false);
>       if (ret) {
> +        qemu_file_get_error_obj(f, errp);
> +        error_prepend(errp, "Failed to save iterable device state: ");
>           return ret;
>       }
>   
> -    /* TODO: pass error upper */
> -    ret = qemu_savevm_state_non_iterable(f, &local_err);
> +    ret = qemu_savevm_state_non_iterable(f, errp);
>       if (ret) {
> -        migrate_error_propagate(s, error_copy(local_err));
> -        error_report_err(local_err);
>           return ret;
>       }
>   
>       qemu_savevm_state_end_precopy(s, f);
>   
> -    return qemu_fflush(f);
> +    ret = qemu_fflush(f);
> +    if (ret) {
> +        qemu_file_get_error_obj(f, errp);
> +        error_prepend(errp, "%s: Failed to flush QEMUFile", __func__);

Ditto, directly return boolean.

Anyway can be done on top, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        return ret;
> +    }
> +
> +    return 0;
>   }
>   
>   void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
> @@ -1874,13 +1880,12 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       }
>   
>       ret = qemu_file_get_error(f);
> -    if (ret == 0) {
> -        qemu_savevm_state_complete_precopy(ms);
> -        ret = qemu_file_get_error(f);
> -    }
> -    if (ret != 0) {
> +    if (ret) {
>           error_setg_errno(errp, -ret, "Error while writing VM state");
> +        goto cleanup;
>       }
> +
> +    ret = qemu_savevm_state_complete_precopy(ms, errp);
>   cleanup:
>       qemu_savevm_state_cleanup();
>   


