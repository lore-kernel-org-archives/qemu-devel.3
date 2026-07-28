Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417E9C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobFl-00076d-2A; Tue, 28 Jul 2026 02:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobFh-0006yE-LX
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 02:25:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobFe-0007VE-58
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 02:25:21 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6P6YC013785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 15:25:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TFRMa42GexJ5dOXoAM5RUpOlhXzSTc0MTfcJraB80h4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785219906; v=1;
 b=YpMI430BSvVYHLwP8sUCmro1DcHvPT676pFbfDytIrAlfvDHOURgxb9R4YHRCNJd
 SC1M9TbpfvSqJh1kttgJSFcPVWOmy9ijNmV75iPfoq+eCMwIMpNNXFMHzZoET63z
 eN9TMhkbAESW39EBEI2D2z668V2bAESiwUfTpumiA07+DzKo8v6r0++RsZUyICz8
 J8yr+JW1rRopinZZ4GdxLhvmcxkmxLMaSsxHAOZFpwHakYlJWXsLl5vHIqaxig9r
 U+wGqDK2sTeK1jebbjqvk0X3vnsC8JGEkr1acHMOcJUPY1mZmtD5CWKoGZDkB7Ny
 rvJ+UvWFQIqSt4wPBcWiXw==
Message-ID: <5f437bad-2ca1-4960-8229-4a9e6107200f@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:25:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: Reject non-migratable large
 blobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
 <amclS3G5VTeZuP8Z@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <amclS3G5VTeZuP8Z@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/27 18:30, Daniel P. Berrangé wrote:
> On Mon, Jul 27, 2026 at 06:23:25PM +0900, Akihiko Odaki wrote:
>> The blob size is encoded as a 64-bit integer in the virtio protocol, but
>> it is encoded as a 32-bit integer in the migration stream, and
>> a large blob whose size cannot be expressed in a 32-bit integer will
>> be corrupted after migration. Deny creating such large blobs.
> 
> Is there a valid use case for such large blobs ?   If so, rather than
> rejecting the blob, we could dynamically add a migration  blocker.
> That would allow the valid use cases, while preventing the migration
> problem.

For the QEMU code path changed here, there should be no practical use 
case for a blob larger than 4 GiB. The non-virgl implementation uses 
blobs as scanout or cursor backing. Such a size is excessive for those uses.

A dynamic migration blocker would also let the guest make an otherwise 
migratable VM non-migratable at runtime merely by creating such a 
resource. This could interfere with host-level VM management. So I think 
rejecting sizes that the current migration format cannot represent is 
better for now.

If a concrete use case emerges, extending the migration format would be 
preferable to making migratability depend on guest-controlled state.

Regards,
Akihiko Odaki

> 
>>
>> Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
>> Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>> Changes in v2:
>> - Add the Fixes: tag for f66767f75c9c.
>> - Add a TODO to encode blob_size as 64 bits in virtio-gpu/blob
>>    VMState version 2.
>> - Link to v1: https://lore.kernel.org/qemu-devel/20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp
>> ---
>>   hw/display/virtio-gpu.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 718ba3039290..987b1b3ea860 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -352,6 +352,14 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>>           return;
>>       }
>>   
>> +    if (cblob.size > UINT32_MAX) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: blob too large (%" PRIu64 "> %" PRIu32 ")\n",
>> +                      __func__, cblob.size, UINT32_MAX);
>> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
>> +        return;
>> +    }
>> +
>>       if (virtio_gpu_find_resource(g, cblob.resource_id)) {
>>           qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
>>                         __func__, cblob.resource_id);
>> @@ -1435,7 +1443,14 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
>>           }
>>           assert(!res->image);
>>           qemu_put_be32(f, res->resource_id);
>> +
>> +        /*
>> +         * The migration stream encodes blob_size as a 32-bit integer for
>> +         * compatibility though virtio encodes it as a 64-bit integer. A newer
>> +         * version of the migration stream should encode it as a 64-bit integer.
>> +         */
>>           qemu_put_be32(f, res->blob_size);
>> +
>>           qemu_put_be32(f, res->iov_cnt);
>>           for (i = 0; i < res->iov_cnt; i++) {
>>               qemu_put_be64(f, res->addrs[i]);
>>
>> ---
>> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
>> change-id: 20260725-blob-8a6a1a85601a
>>
>> Best regards,
>> --
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
> 
> With regards,
> Daniel


