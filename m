Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F49AC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wztX1-0007BH-Am; Fri, 28 Aug 2026 06:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztWz-0007Aw-UD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:09:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wztWx-0000Cu-Jd
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 06:09:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SA7V1r2167855
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p4dr4AvofMQN7UOgn7w3iv3oeKbDUWIPLbdFXK32DGI=; b=J2fj6pRVI5cBkuJP
 kjJjDCjGrSYRfpuVoAWe0N+LDSWP7+svCYLu6CB0vN1ctbzc4YhCFnGn8rbYwlwS
 co4IDokIMeotvymnrbSSflnFQNaaFq2MBrdcW/HNkUarUIs3pX0jh2qbOMI83RM1
 6GmRR7w3n8ctgGNiRUHtkg1VV/tb3c2WWEt8b/2hjP+o7P60gHLMvHHxo+89Fm9K
 NKDwZ5bA2hN1Lo0x5Ms/rfcYwQBqz1kXbJDz4Z792o4xXp1cvkpFe+49mM6kYdx5
 3IipY0TtyNEOF6h8NHDEYnuWkrsK8YAScZNFjEPaBprokPzvH1FKrQbypeGFIF+2
 bjxQGQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb6h00ft9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 10:09:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so15819741cf.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787911788; x=1788516588; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p4dr4AvofMQN7UOgn7w3iv3oeKbDUWIPLbdFXK32DGI=;
 b=Tr4AKU97FX3eLe/eEfwIwKKVF/0LYx4B/kCATNO8+Vze6E6/Om8Sjh6eupLSOB5DBG
 t2ptOLaKsV+u+lIU7y2+vfN3/GzD/L7Lseg08LNbxIKgwY/s2UhQmwKZv2jmz/jCyVAC
 4yZOVu2daOevHKSgyJoMgnvbRutqOU5xhmp53opZgMBJgz7IAzKA91NrwD7cb2L7vw7W
 76IY+TmmDlycwpeQRFjNV03xjx1fYJ5aCCBeyRdbXRDQBMWLA7xgCTBJQuk53MSyy1zO
 GryXux8w6d7OUL85hkne6hkbmAHLNg7Z1AszVRA6sXdvtnPq9EBOm4NBZygwHg7sLv8K
 Agrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787911788; x=1788516588;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p4dr4AvofMQN7UOgn7w3iv3oeKbDUWIPLbdFXK32DGI=;
 b=NJ6xVs0gpStB4ABci0+9q3TwLoUbJLZNRJK6ArwSpMOpXBTdP4ZUj9631OXPrLP7Bd
 uHczxc2o2zRntxJtzUnLSSq5uycfH6VJ/rmY3FTO5WV1ErHxe0ReKwJDRolCJyYscke/
 naiRPi/5oDY5a3nTJHTQrwAcHEzNqMT+jr3dAR546mvNcU6KAsjtSzpMUC8jotGf2bCO
 qQAE0qP2+aFYLBnLps6qXOqOp0rjNBWZxeRH8eDHK9eKv12doLWy6J3TwOA8Oks6Y6av
 0tkb2MVsa+1ASxBFMTTz6SNhG1uc5HOC14M5tC4k9cAhD0ptoWhi2K7mYAFUAcsw/Uh6
 pAjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrLlMUrVfC/cN0jmIgv7p9UMQQyzPiccmhEgSq5r0QVCqS+SyyL6xEh9SF5zxWfxl1by2V6aNaBPcmz@nongnu.org
X-Gm-Message-State: AFuF++mav8XhpOmBSfOi+Jt5qKyT4Bea9IYLDj+yEwB30oq7CKFaNArj
 uFe64UOC+s1+9ChW06FakmrPBl0qlkCkKgtYYXoC7UMd5HBHAWo+BFzdvNTY3I054iO/IybX5PY
 nEaAAISh13Q1QRKWvESXtIGz8o9N7AMIqNB0i1d1vNjRiDqPWbf6nVczZIA==
X-Gm-Gg: AR+sD11BvjeDuMCPFxKgsxL/mKLrABwun2dgeTP70fviYhe3ypxZPYJOB4Xv8RM7VX3
 fTXP8Koo3O7bsweP/8vUoHDt/rTy0sYJepOknRS3umD1YAxNbVxGMo33DrNfVLuHJBqO+xEKh47
 ANBp5AWeaEM0v9M9OoVfGQ4dz+0V3j6Hrq17u0r170NOBgJdQCaChXTJFf2yi5CLJ04KH3LUb31
 LTH2ui6xB0MgbHMt70eDVYxxlCXzeouU7zhh+35O11YDXKTj7HworjaIU/RCo6bHr2RCdn77TVQ
 BgfpTSfFha1CBLknl37IRqE98TKm5My1oJsYvN0nsnFVdU1yIekRalZ8fRC7LMnTqKpThqQeP3U
 kJlimxCAeTxN4N/KtsAgt/vKNWo2piflCXw==
X-Received: by 2002:a05:622a:58c:b0:52f:b36e:4075 with SMTP id
 d75a77b69052e-52fb93b2b20mr62068541cf.10.1787911788459; 
 Fri, 28 Aug 2026 03:09:48 -0700 (PDT)
X-Received: by 2002:a05:622a:58c:b0:52f:b36e:4075 with SMTP id
 d75a77b69052e-52fb93b2b20mr62067871cf.10.1787911787840; 
 Fri, 28 Aug 2026 03:09:47 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac8e61sm2972554f8f.13.2026.08.28.03.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 03:09:47 -0700 (PDT)
Message-ID: <85a686ea-d8f9-4242-96df-a0296c581be8@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/49] tests/qtest/device-introspect-test: fix test
 without HMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-16-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-16-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7WeLxiBRvmBENjYZQiSKS7YexaA9lj4X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX1AfsU2VMdcxq
 Fs3XOAVyfXniGg+dUhG1Z+0Flge7lmUvjUmHHTxcLmz8Y9XCiegc5MOeB5TitpDcuj653UfTiO9
 43SzpkcgHiqJm0xIKCvcPn2aWehX7PA=
X-Authority-Analysis: v=2.4 cv=KPpqylFo c=1 sm=1 tr=0 ts=6a915e6d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=0m_H8MN7WX6ae-CucloA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7WeLxiBRvmBENjYZQiSKS7YexaA9lj4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4NiBTYWx0ZWRfX4wj+VnGo5jno
 Ti3bieKHuEDlJ8pMbAn3SE1yg0QuJcZHs5sMLcGnZ8EFwLeQWUKEWC1241PCZSBzYOChREXRxP7
 uAU8zTUQ8o4dRsvRvNqM7YY+9GoAsfG2R9Omd7aFNi9yNxrIkb7zma0jnYq0daqKF39+mqnKJ7Q
 s98C/MNqf/N9zeBP1XaCzf3US9EviOaUfY9l0r0eJZIAEv6ATOAzFZVFe1In3a7V/pQfTU5c3hf
 CyH/KlOyCDTwRV0JjxZxlcALoDqxWzuJhaBVEu9d45RmO84h/U4tD/oZuYVqzjf+/eIhs/qU8p+
 S1Dnskckdi+Ge15evuYr6MwYxU7t5Z9QEUHvQkZ7zDbLd9EY7tDdcQAtZxaxzGPUtoypPqbBoqj
 wRnCXunlo4hBSu2IXW0xYXUGZ5/Z6hJWmH7CDUhQJUHQsRquwLaGtz72+kLp5m8k6sb6LWtJQDG
 KsWVpgtGcyEIXvNqndQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Replace "info qom-tree" with recursive qom-list walk.
> Disable HMP-only code paths, info qtree, kinda duplicating the test.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/device-introspect-test.c | 111 +++++++++++++++++++++++++++--------
>   1 file changed, 88 insertions(+), 23 deletions(-)


> @@ -100,11 +100,60 @@ static QList *device_type_list(QTestState *qts, bool abstract)
>       return qom_list_types(qts, "device", abstract);
>   }
>   
> +/*
> + * Recursively walk the QOM composition tree via qom-list and build a
> + * string representation.  This serves two purposes: detecting dangling
> + * pointers (qom-list would crash QEMU) and detecting leaked objects
> + * (by comparing the output before and after device introspection).
> + */
> +static void qom_tree_walk(QTestState *qts, const char *path, GString *result)
> +{
> +    QDict *resp;
> +    QList *list;
> +    QListEntry *e;
> +    GList *children = NULL;
> +
> +    resp = qtest_qmp(qts, "{'execute': 'qom-list',"
> +                     " 'arguments': {'path': %s}}", path);
> +    g_assert(qdict_haskey(resp, "return"));
> +    list = qdict_get_qlist(resp, "return");
> +
> +    QLIST_FOREACH_ENTRY(list, e) {
> +        QDict *prop = qobject_to(QDict, qlist_entry_obj(e));
> +        const char *type = qdict_get_str(prop, "type");
> +        if (g_str_has_prefix(type, "child<")) {
> +            const char *name = qdict_get_str(prop, "name");
> +            children = g_list_prepend(children, g_strdup(name));
> +        }
> +    }
> +
> +    children = g_list_sort_with_data(children, (GCompareDataFunc)g_strcmp0,
> +                                     NULL);
> +
> +    for (GList *l = children; l; l = l->next) {
> +        const char *name = l->data;
> +        g_autofree char *child_path = (!strcmp(path, "/"))
> +            ? g_strdup_printf("/%s", name)
> +            : g_strdup_printf("%s/%s", path, name);
> +
> +        g_string_append_printf(result, "%s\n", child_path);
> +        qom_tree_walk(qts, child_path, result);
> +    }
> +
> +    g_list_free_full(children, g_free);
> +    qobject_unref(resp);
> +}
> +
> +static char *qom_tree_str(QTestState *qts)
> +{
> +    GString *result = g_string_new("");
> +    qom_tree_walk(qts, "/", result);
> +    return g_string_free(result, FALSE);
> +}
Please split in 2 patches, refactor adding qom_tree_* first,
then restrict with CONFIG_HMP next. No need to repost, for both
patches:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

That said your new method could be used in test_properties() in
tests/qtest/qom-test.c and test_object_rng() / test_docs_config_ich9()
in tests/qtest/readconfig-test.c. Left as future cleanup.

