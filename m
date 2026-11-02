Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E366078276
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YiaboSec
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuHP-00039z-UX; Mon, 02 Nov 2026 10:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNuHL-00038y-9t; Mon, 02 Nov 2026 10:48:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xNuHH-0006xm-RM; Mon, 02 Nov 2026 10:48:57 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2EEFWF3044370; Mon, 2 Nov 2026 15:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ubXG/w
 yOS2Fzvlza9HrOPTls0CV96aJuGg7XkFrP3Qw=; b=YiaboSecj3Q1oHHB0pVB1f
 6MZ5aKAg2MIzO2anqIvHN+0IOXl5b+mJwbmtpLGmNao60yT/CFvvjKSjtSO2hOks
 P0OOouRCXoItwdnrE1YuFLUrD5jQEp0fCkrCpGnyiZ0JZo+SAUIcsAVuGb2zGGQl
 NfrHungDKABhqw+RdXIIb8RA/+hK+25ci5yWOq5d+nEmjJAk9QnTgE1iJCR1l0ZS
 BEytpn7UyoEDoNSjqoA5LzrGVOY3uGghadv/Sk/+pV3lazqKkrRsWjFgqBmWrcv9
 32rFwHi+y8DUQscWY/w6vGaiO5ntVHfyPgqujJdAE27QKGsQ2xfPLdynytnZMdfQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhhkkt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 15:48:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2Dp3Di1046621; Mon, 2 Nov 2026 15:48:51 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxxch5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 15:48:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2FmoSv10093174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 15:48:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C34BF58067;
 Mon,  2 Nov 2026 15:48:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE57758056;
 Mon,  2 Nov 2026 15:48:49 +0000 (GMT)
Received: from [9.61.98.239] (unknown [9.61.98.239])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 15:48:49 +0000 (GMT)
Message-ID: <92a5bdce-af21-4e8a-b869-57e903531a77@linux.ibm.com>
Date: Mon, 2 Nov 2026 10:48:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 49/78] util/event_notifier: more strict API
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
References: <cover.1793207602.git.mst@redhat.com>
 <05f5ab90ea52b0151958fd2506c15858e3e80442.1793207602.git.mst@redhat.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 xsFNBF7EiEwBEADGG0EtNKnjp+kQfEVqlqxXoBHjnaQptFpMgxNlz2GtqOujY6nzEWnybIXY
 63XUTmMS/tWUf2DTbNCNoWwumGM/I2Gj1uGyMnc4Q477BQlL/e2/9MRaut11rwHsi4zmWylc
 jO0eFTSLFA8yFBj9osT3uZzk5TwWkD8sf+rD916fFVk0G39uYEd5sjEzjeOf9/dwXyZpjJY6
 api1pUHEw7weRvOnllJAfIKFz+KoR6d7ezvMF9zOYHF73FGeSVIYoIEUhA5Cdg60rSlTtHb2
 cftex3/cEapvY5bK3CKJ33BVVK10Bht9XfVaA/AOcg/3o5ZbhSIwz4xScGsEVf/Yr368YMdr
 3VkCZrmN2ppmVRz/RvAmCyItnmzoVDlSREA6Faw6S0x8Oi7lN0cKh2hy9VPcVupraXJZrdAh
 GtdU+jrJvSbpdsrX8F7K3RwynbiqGrqC0izGla04hhtei/uwthatglukuxep4PknDGbzijg8
 Ef7A8t3qEVklUDrsnNPN5HbR9QQdeF0HuWsDTfILbZv1MICfOK3BCDeT5mJWaJCoQ2rbuljM
 e1hFSt+mr7GV4h6NcBE+uGIqDSzQORtyTo0uBV4et3cSE84JxOfXBMrj0TlL1855JaIoPWEN
 uhDRB/dHW8+Fumq2du5hLcaXPka+MO26cNVKVLF0/JjwMTZ9bQARAQABzSJFcmljIEZhcm1h
 biA8ZmFybWFuQGxpbnV4LmlibS5jb20+wsGuBBMBCABYAhsDBwsJCAcDAgEGFQgCCQoLBBYC
 AwECHgECF4AdGGh0dHBzOi8va2V5c2VydmVyLnVidW50dS5jb20WIQTSxgUEyej1aM/lh7U4
 J7IScb+VYgUCYel8TgAKCRA4J7IScb+VYsHAD/9BSQj7HeJf90PttOmVh35Bb4QyHLZ4g+9x
 waM59JCKGbiURuNRIGnoRarYXHk6vfy19v8v56Dy1IOlKWaRnizp5Mw9zXBBTCs4fgNbOzY/
 SggFY2UzcziXDG29X9zznq5LgY1Jf/cwm1O+rn89GKCZWZhLEB2wKzBj7hum7NBdW+lxfVwp
 2qONGDerttWDwAHxJ995k9aDJahq9kIKEMEZbrTQ8JI8KZGoox6+HA04EhoNzxvbV0J+/gLJ
 2DkvxN5/xmcD3z+s8B5ev3NarOF17AIA9oCdfu8CPAupcNqJW86m19P5q6AyRB2ZLyAIAAhr
 HCXrnlh/8HJW1yCOVXxprFdpg1SX1fuArjbFAh53vVVDfkZlwHeTeE7+3y1rtDLfy830pqdD
 ymv94yey2y1+iZBdbaW0fSC/JkjkOCy8oZawkH3geM4MXV4ze4gbBH6BhxW/0gbEYjnLm3FA
 53JcXwhHQFPWIYEYYPvATJi0JUiMY1Znkm3QBWDOCXSrG0tHpAclBa9L40zLRwA1h9YOMFEs
 qvKijUdvcDf4sTdJ+A6YL66grzul5vNt06NlqsI8HUDHE6vghqyWxupCav2+9b1BuLie++er
 b8OCo5n3TUHsVMjYJEePU1EkcCa84dCm+CXqPthgRv0sbe4UQEd/qUoVMdWj7Q7FL96mBn0G
 zM7BTQRexIhMARAAp+k1sC4y7Wtwjqtfu9wIihvY/Vot0v/sKg8CRGRIIRGLiCeA9o+2ZlxC
 jYztT3Leri5Vo5z09OmRMvoFLJjcHMCG5sYeZwOWNAbeuAxGkIMDSB4pLl3t2c+1PQuMBCd7
 +mRZFaMEJfT3nhdUKxy2rp1+YucnA67xGXUJCiD5l9UmhPqa7SAYlpMAqDz7cmBo25c/UNm1
 Tpwjrh70jq/4guV5gnprawH8nkRjdKH1JvKWvkuaB7FNZ9IuSHlWclcQX4IQMsaxsU2emAbP
 VYv7l4YNlKfdlJd8tuEodjuMLOBnr7e9H0hVNUWGFN9bkBNRu3zi/jvhyu15Iu4euR/WdVNu
 2K2iYxIfiGMnv0F/a6R1bm10lCJrjyf23J8DYIeH4YmHvOOqYFkq3DWOctlXbb3+aABqjYt3
 mkiOLXeplqbo/m3rWcGNd8Q/d1aVA0wm5+Nt3RdSuXG2FHOFdVUQKPLpf1NUH/LInBhS/9Ys
 ajm6tWXKv7hxwWmyz0u/th6gUra3KpARB1ypebWHULLNzKGwVS81XNs76QhXwX04cyiwLqKb
 WqLqJKThz+rLa09Ap+eO/UzPfFXvWYWfTeFRIQ/tKF332ZzRR8Xrh/fk//YXyRfpoE/7i5uz
 ve0HZWp5jXg9Yb+S6g0+XUKznnN9B8WLLCcuRIuSa722070v7KsAEQEAAcLBdgQYAQgAIAIb
 DBYhBNLGBQTJ6PVoz+WHtTgnshJxv5ViBQJh6XwwAAoJEDgnshJxv5Vib28P/1BYT5gvjuEB
 A80AXo/IqycicXxDJtrfmyw4COP7bi7AuiDcKyA1wRzC51paKwPFB8Unk2GvG4DV6aDmGTJY
 +GeCYgthQ+znW461S8B6GqDCAQt2VDNNFVU+gTuh7vYQOgt/OjtiiAvMIJBVRbXoNSRokKOF
 tpTiXf3ZOsAkot5ZmxE0TV94v18sp/bC84YvFyaxpw5bilT7bmpcq8B8/3yb0kmy6gXLcQAp
 OnomV3sQBmm050amiO3tvxMNv8J71AvNdTG/rojTDKUl2Nw4f+aw4nVw874m2XpEe9JGRw54
 5d2dN8k3GpzcTBe9fCQPOFHOGkQ1CgptDkQuQVD3DIeNzQjXf6xehEymIKnLOkukT2smV0zh
 fj08z7eiv+dsmnBsbhdM6DKU8qIgkTu77TfHUKjjOY/Mj0YHPuH/J4b1AZFxBhGP0BTKiB2W
 CR6/49XVKvY1jHxgadSSNCD+f7tEqUNBlVl+P0emMJaYpK1+gy88ma4g3nvyOVe/VzDPjGDC
 4HX/6RAR4Dbzry6/epWTTji+7ApzePzmJzPcuzD31ICsgT2dJ6ydxyxxXikBFJqx6BPOF+u+
 1BtKcTz1ek3I2sWvBM1V5CKaFw7iNXxS6HgS2scuAT2awKq+BQlt778/GfBWpXonfqixMvit
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <05f5ab90ea52b0151958fd2506c15858e3e80442.1793207602.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qi2IwPyaihO95HUb6BE31UtAB0xzxD-8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MiBTYWx0ZWRfXyT+q1JZd9Phw
 K5ugc3LR94fb7oIsSQei2YCmvhNKL6cH94svqXXPA6+ED7NpSl3HnVbwXY+8c2Yaz3GEiUz//31
 Qy99x8eKbHef+b5u2EEIgXeQ22F+wUE=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae8b0e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=6R7veym_AAAA:8
 a=20KFwNOVAAAA:8 a=sOfcSTfvlG6xgFu-lo4A:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MiBTYWx0ZWRfXy9uOZHCs3WUy
 jlQZHRx/jY9j27MXYNKotYmLZ3AvsdCNjM3AH9MMnjd6P98u23ghUAlzVsUvonmw/ZpxKE28NZR
 ZGF1KDGZ4N0BslxUIyRDiIqIPe0FdvcWdAsptJZN2VViwJGjmrhWPNS4oRnq8caO2ac8xJfaSec
 /ISipEGdbeXSLde2G9RcTIwCRh1TZ+QCbzSDxFX7oiEf1u9MBydE/hPIYhWqEsdljgwGdlNHaBz
 c9T5+QQifQXUcTXVsrCElMQaj+0X3hft0Cd0Udvy2WMLjy4yh6HnKLdbTNlVkS7WWjzcqIrfFjZ
 5rimuIZvGMJZKEYLi1JMggAHTmZtBDgP5ME/xwZxQ9D2ESiZfB3HWrDsoaTc9rzeIy4/sXvLRnf
 oURxgm3GPMv3tGP7CgvbAHj+LmPOGny7Aa8A8CXLY37PM2+tvTrre3wHvQCaTWfFNe29Z9jH3/X
 pxjxouSVs7z48neb4lg==
X-Proofpoint-GUID: qi2IwPyaihO95HUb6BE31UtAB0xzxD-8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/26 1:16 PM, Michael S. Tsirkin wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> We have .initialized in EventNotifier to track was it actually
> initialized, and we have a comment that @fd passed to
> event_notifier_init_fd() must be an eventfd object.
> 
> Still, there are two specific users, which ignore these things,
> and use -1 as specific value storing in notifier, to mark it
> "uninitialized".
> 
> Let's make strict API:
> 
> - store only valid FDs in initialized notifier
> - _set() asserts that passed fd is valid
> - _get() asserts that notifier is initialized (actually, except
>    the two specific cases we rework, all other callers are not
>    prepared to notifier being uninitialized when _get() is called.
>    In this case _get() returns 0 (which is a valid fd), and caller
>    will mistakenly use it, which is worse than abort())

Well, there are other cases that would require rework not addressed 
here, as this commit breaks (at least) vhost-vsock-ccw and 
virtio-net-ccw (for vhost=on) on an s390x host. I'll look into that, but 
was not prepared for such a late surprise.

> - for two specific cases, implement additional getter for .initialized
>    field itself
> - zeroed notifier is uninitialized(.initialized is false)
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-ID: <20260911185800.134135-1-vsementsov@yandex-team.ru>
> ---
>   include/qemu/event_notifier.h      |  1 +
>   hw/remote/iohub.c                  | 11 +++++-----
>   hw/virtio/vhost-shadow-virtqueue.c | 32 +++++++++++++++++-------------
>   util/event_notifier-posix.c        | 10 ++++++++++
>   4 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
> index 8a4ff308e1..820efe7722 100644
> --- a/include/qemu/event_notifier.h
> +++ b/include/qemu/event_notifier.h
> @@ -39,6 +39,7 @@ int event_notifier_test_and_clear(EventNotifier *);
>   void event_notifier_init_fd(EventNotifier *, int fd);
>   int event_notifier_get_fd(const EventNotifier *);
>   int event_notifier_get_wfd(const EventNotifier *);
> +bool event_notifier_initialized(const EventNotifier *e);
>   #else
>   HANDLE event_notifier_get_handle(EventNotifier *);
>   #endif
> diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
> index 988d3285cc..ab698d9f03 100644
> --- a/hw/remote/iohub.c
> +++ b/hw/remote/iohub.c
> @@ -28,8 +28,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
>       for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
>           qemu_mutex_init(&iohub->irq_level_lock[pirq]);
>           iohub->irq_level[pirq] = 0;
> -        event_notifier_init_fd(&iohub->irqfds[pirq], -1);
> -        event_notifier_init_fd(&iohub->resamplefds[pirq], -1);
>       }
>   }
>   
> @@ -85,9 +83,12 @@ void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg)
>   
>       pirq = remote_iohub_map_irq(pci_dev, intx);
>   
> -    if (event_notifier_get_fd(&iohub->irqfds[pirq]) != -1) {
> -        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
> -                            NULL, NULL, NULL);
> +    if (event_notifier_initialized(&iohub->irqfds[pirq])) {
> +        if (event_notifier_initialized(&iohub->resamplefds[pirq])) {
> +            qemu_set_fd_handler(
> +                event_notifier_get_fd(&iohub->resamplefds[pirq]),
> +                NULL, NULL, NULL);
> +        }
>           event_notifier_cleanup(&iohub->irqfds[pirq]);
>           event_notifier_cleanup(&iohub->resamplefds[pirq]);
>           memset(&iohub->token[pirq], 0, sizeof(ResampleToken));
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 0fae35ba1a..c97bd9f93f 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -751,6 +751,15 @@ static void vhost_svq_handle_call(EventNotifier *n)
>       vhost_svq_flush(svq, true);
>   }
>   
> +static void event_notifier_set_or_zero(EventNotifier *e, int fd)
> +{
> +    if (fd == VHOST_FILE_UNBIND) {
> +        memset(e, 0, sizeof(*e));
> +    } else {
> +        event_notifier_init_fd(e, fd);
> +    }
> +}
> +
>   /**
>    * Set the call notifier for the SVQ to call the guest
>    *
> @@ -761,17 +770,13 @@ static void vhost_svq_handle_call(EventNotifier *n)
>    */
>   void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)
>   {
> -    if (call_fd == VHOST_FILE_UNBIND) {
> -        /*
> -         * Fail event_notifier_set if called handling device call.
> -         *
> -         * SVQ still needs device notifications, since it needs to keep
> -         * forwarding used buffers even with the unbind.
> -         */
> -        memset(&svq->svq_call, 0, sizeof(svq->svq_call));
> -    } else {
> -        event_notifier_init_fd(&svq->svq_call, call_fd);
> -    }
> +    /*
> +     * Fail event_notifier_set if called handling device call.
> +     *
> +     * SVQ still needs device notifications, since it needs to keep
> +     * forwarding used buffers even with the unbind.
> +     */
> +    event_notifier_set_or_zero(&svq->svq_call, call_fd);
>   }
>   
>   /**
> @@ -814,14 +819,14 @@ size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
>   void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
>   {
>       EventNotifier *svq_kick = &svq->svq_kick;
> -    bool poll_stop = VHOST_FILE_UNBIND != event_notifier_get_fd(svq_kick);
> +    bool poll_stop = event_notifier_initialized(svq_kick);
>       bool poll_start = svq_kick_fd != VHOST_FILE_UNBIND;
>   
>       if (poll_stop) {
>           event_notifier_set_handler(svq_kick, NULL);
>       }
>   
> -    event_notifier_init_fd(svq_kick, svq_kick_fd);
> +    event_notifier_set_or_zero(&svq->svq_kick, svq_kick_fd);
>       /*
>        * event_notifier_set_handler already checks for guest's notifications if
>        * they arrive at the new file descriptor in the switch, so there is no
> @@ -928,7 +933,6 @@ VhostShadowVirtqueue *vhost_svq_new(const VhostShadowVirtqueueOps *ops,
>   {
>       VhostShadowVirtqueue *svq = g_new0(VhostShadowVirtqueue, 1);
>   
> -    event_notifier_init_fd(&svq->svq_kick, VHOST_FILE_UNBIND);
>       svq->ops = ops;
>       svq->ops_opaque = ops_opaque;
>       return svq;
> diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
> index 83fdbb96bb..f595945af7 100644
> --- a/util/event_notifier-posix.c
> +++ b/util/event_notifier-posix.c
> @@ -27,6 +27,7 @@
>    */
>   void event_notifier_init_fd(EventNotifier *e, int fd)
>   {
> +    assert(fd >= 0);
>       e->rfd = fd;
>       e->wfd = fd;
>       e->initialized = true;
> @@ -96,14 +97,23 @@ void event_notifier_cleanup(EventNotifier *e)
>   
>   int event_notifier_get_fd(const EventNotifier *e)
>   {
> +    assert(e->initialized);
> +    assert(e->rfd >= 0);
>       return e->rfd;
>   }
>   
>   int event_notifier_get_wfd(const EventNotifier *e)
>   {
> +    assert(e->initialized);
> +    assert(e->wfd >= 0);
>       return e->wfd;
>   }
>   
> +bool event_notifier_initialized(const EventNotifier *e)
> +{
> +    return e->initialized;
> +}
> +
>   int event_notifier_set(EventNotifier *e)
>   {
>       static const uint64_t value = 1;


