Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFACCA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 12:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEn5k-0002uK-Ut; Thu, 08 Oct 2026 08:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xEn5i-0002tW-7a; Thu, 08 Oct 2026 08:19:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xEn5g-0004j7-89; Thu, 08 Oct 2026 08:19:17 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BZW121225072; Thu, 8 Oct 2026 12:19:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mdJv0E
 3YTyd1KpejfoRYxwxXhmaJDvlsH231Lnrb7wc=; b=HSQK7jkruf7kmWSvI2erFE
 ++638OO0Hlg+K9jh5kY2wD1oAoYEaAF0SqgD7RU2tVekOZ8wqcPYLrOm3/E/r0lz
 QN+C00zA9QX+zqxODrdNe3SaHc0o8K/TczSjWDbJdwosZl7veBfNehKs1/beXntg
 Lz3Hp5K6MQoCZwRPEr3SxDM7QG8BtL9By5LP59CPgZNXJf3Q9NhHa+9KME2Qt4NW
 JKc1m1cs8MwuHoFY6os+3pTgUmskuzbvcbe5rLeNqWWVFXD/af4VYyR6jLQGrFMD
 IYAx4Wr/m8JYF1UaJlc0ybhJTE6cx9CiztT39pFN0o2bBy4xvTKgsVI9WnnJFQ5Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvk8qs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 12:19:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698BHrM13352381; Thu, 8 Oct 2026 12:19:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5qces-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 12:19:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698CJCNg26411588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 12:19:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E3B58061;
 Thu,  8 Oct 2026 12:19:12 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A255758057;
 Thu,  8 Oct 2026 12:19:11 +0000 (GMT)
Received: from [9.61.5.156] (unknown [9.61.5.156])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 12:19:11 +0000 (GMT)
Message-ID: <c56ce1e0-3dcb-441c-bacd-154ac5a82f41@linux.ibm.com>
Date: Thu, 8 Oct 2026 08:19:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/23] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhuoying Cai <zycai@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
 <20260930152420.1956230-17-farman@linux.ibm.com>
 <B8BD07F5-B1AE-47A6-AD08-0B5E0151AFF6@gmail.com>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <B8BD07F5-B1AE-47A6-AD08-0B5E0151AFF6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WmidP2R2kk8X0gjjAaWo2gSdbXBNN_qp
X-Proofpoint-ORIG-GUID: 6fcXqhw5nZydXkTZJgX8NENLOWcdQjeT
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac78a42 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=JYA0kUJgYUewswd0S8MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA0OCBTYWx0ZWRfX+Rwa5+Q6nM/q
 5NNenQc0WHnqAVYe9HXB5sLSvCZRaEl2N7uUdh9tMhHckdNhFzZ61faLSBlw+m7GjXV0ghWFSWN
 mraTJYND4rPlF2FT301Xom/X5of6PVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA0OCBTYWx0ZWRfXwuZ5rFLglMki
 VpPIkc7ZJCfkGlFViXzY3WHax2CHhbYH5RZ1UyqfMpSrKsp+QE4f0vYSBxsQJIboVYn6sbxpBX1
 XbVxFZzj9nRcyrgtZIes5It3mUIYU+AZUFpNxy0uCGb8InPPY3G/s7oo88zPh1OmQFU2vN84w6Y
 MKqHiHFy5fYrAqPh/NwY9LuUUxQv5fcp5S5sPAuMfyo8EkG9NyTM/zjBYHdiqISim+yJUT1AaUC
 MZd01gYhtRJDSlR2FEMX+CyzlzdCl5iYruwoWvoMqYZfOZrzjqIhmGCtqQXI2oBhSqnq33ey56B
 mPKhjM9UGhQ1lXMBtL2F/oRoKp+fRy2YvZjrVavfLk5twgGB6rZInumZgVtiw/Vm4kgrOaBvgyV
 Qr6dinRafkunkzGMJRpVEfF3vSD7T1pWwx0DvRbiI+dQZXb5cSuKL7yx99pML6hk4XLIsjKEpd9
 PPNzwYNnHihZWrtumow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10/7/26 4:02 PM, Bernhard Beschow wrote:
> 
> 
> Am 30. September 2026 15:24:13 UTC schrieb Eric Farman <farman@linux.ibm.com>:
>> From: Zhuoying Cai <zycai@linux.ibm.com>
>>
>> The pxe test for a net device does not fail gracefully when the
>> s390-ccw.img in use was built without support for booting that device.
>>
>> Add a boot_dev_support check that searches for a known string in the
>> bios image to confirm boot support. If absent, the test is skipped
>> gracefully instead of failing.
>>
>> Also re-enable pxe-test in qtests_s390x, which was accidentally
>> removed by commit 973d97feca93.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Tested-by: Joshua Daley <jdaley@linux.ibm.com>
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> Link: https://lore.kernel.org/qemu-devel/20260924222949.147720-7-zycai@linux.ibm.com
>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>> ---
>> tests/qtest/meson.build |  1 +
>> tests/qtest/pxe-test.c  | 85 ++++++++++++++++++++++++++++++++++++++++-
>> 2 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 33f58b0e95..341f6ad1ba 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -292,6 +292,7 @@ qtests_aarch64 = \
>>     'migration-test']
>>
>> qtests_s390x = \
>> +  (slirp.found() ? ['pxe-test'] : []) + \
>>    qtests_filter + \
>>    ['boot-serial-test',
>>     'drive_del-test',
>> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
>> index e85dec5a4e..5c6415b936 100644
>> --- a/tests/qtest/pxe-test.c
>> +++ b/tests/qtest/pxe-test.c
>> @@ -26,6 +26,7 @@ typedef struct testdef {
>>      const char *machine;    /* Machine type */
>>      const char *model;      /* NIC device model */
>>      const char *extra;      /* Any additional parameters */
>> +    bool (*boot_dev_support)(void); /* optional: boot device support check */
>> } testdef_t;
>>
>> static testdef_t x86_tests[] = {
>> @@ -58,8 +59,80 @@ static testdef_t ppc64_tests_slow[] = {
>>      { NULL },
>> };
>>
>> +static const char *s390_bios_load(gsize *len)
>> +{
>> +    static char *cached_contents;
>> +    static gsize cached_len;
>> +    const char *qemu_bin;
>> +    g_autofree char *cmd = NULL;
>> +    char dir[PATH_MAX];
>> +    char *found = NULL;
>> +    char *path = NULL;
>> +    FILE *fp;
>> +
>> +    if (cached_contents) {
>> +        g_test_message("Using cached bios contents");
>> +        goto out;
>> +    }
>> +
>> +    /* search the qemu binary's data directories for s390-ccw.img */
>> +    qemu_bin = qtest_qemu_binary(NULL);
>> +    cmd = g_strdup_printf("%s -L help", qemu_bin);
>> +    fp = popen(cmd, "r");
>> +
>> +    if (!fp) {
>> +        g_error("Failed to run '%s'", cmd);
>> +    }
>> +
>> +    while (fgets(dir, sizeof(dir), fp) && !found) {
>> +        dir[strcspn(dir, "\n")] = '\0';
>> +        path = g_build_filename(dir, "s390-ccw.img", NULL);
>> +        if (g_file_get_contents(path, &cached_contents, &cached_len, NULL)) {
>> +            found = path;
>> +        } else {
>> +            g_free(path);
>> +        }
>> +    }
>> +    pclose(fp);
>> +
>> +    if (!found) {
>> +        g_error("s390-ccw.img not found");
>> +    }
>> +
>> +    g_test_message("Loaded %s", found);
>> +    g_free(found);
>> +
>> +out:
>> +    *len = cached_len;
>> +    return cached_contents;
>> +}
>> +
>> +static bool s390_bios_has_string(const char *needle)
>> +{
>> +    const char *contents;
>> +    gsize len;
>> +    bool found;
>> +
>> +    contents = s390_bios_load(&len);
>> +    found = memmem(contents, len, needle, strlen(needle)) != NULL;
> 
> MinGW-w64 has no `memmem`, so this patch unfortunately breaks the MSYS2 build with GCC. We might need to provide our own implementation like we do with other functions: https://lore.kernel.org/qemu-devel/20260216102951.150381-2-kkostiuk@redhat.com/ .

Oof, sorry about that! Thanks for the report; will work with Joy and 
Matt to get this repaired. (And I'll figure out why I didn't stumble on 
this in my build tests.)

Thanks,
Eric

> 
> Best regards,
> Bernhard
> 
>> +
>> +    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
>> +    return found;
>> +}
>> +
>> +static bool s390_bios_has_net_ccw(void)
>> +{
>> +    /*
>> +     * Assume that netboot support always includes virtio-net-ccw support.
>> +     * Check only that netboot code exists, rather than probing virtio-net-ccw
>> +     * support directly.
>> +     */
>> +    return s390_bios_has_string("Network boot starting...");
>> +}
>> +
>> static testdef_t s390x_tests[] = {
>> -    { "s390-ccw-virtio", "virtio-net-ccw" },
>> +    { "s390-ccw-virtio", "virtio-net-ccw",
>> +      .boot_dev_support = s390_bios_has_net_ccw },
>>      { NULL },
>> };
>>
>> @@ -90,6 +163,11 @@ static void test_pxe_ipv4(gconstpointer data)
>> {
>>      const testdef_t *test = data;
>>
>> +    if (test->boot_dev_support && !test->boot_dev_support()) {
>> +        g_test_skip("The bios does not support booting this device");
>> +        return;
>> +    }
>> +
>>      test_pxe_one(test, false);
>> }
>>
>> @@ -97,6 +175,11 @@ static void test_pxe_ipv6(gconstpointer data)
>> {
>>      const testdef_t *test = data;
>>
>> +    if (test->boot_dev_support && !test->boot_dev_support()) {
>> +        g_test_skip("The bios does not support booting this device");
>> +        return;
>> +    }
>> +
>>      test_pxe_one(test, true);
>> }
>>


