Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EAC624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x15Gj-0000Hw-Dn; Mon, 31 Aug 2026 12:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15Gd-0000HR-9h; Mon, 31 Aug 2026 12:53:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1x15Ga-0006hY-Hi; Mon, 31 Aug 2026 12:53:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VG1eNb2749260; Mon, 31 Aug 2026 16:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=lnhh0RT2qk2Y/EQ3cL/iJZLV/SxVFL
 u9GXkcSyeKcLI=; b=HU9CVIWfk0nesGhVHlwdVLatEsYenshJFGaZaHz8AZDVYi
 wcMCTJ5NhvjPRLgF8fx/PZqeIC6Wgxm4nu4b63XptXG6JMHV3mViSWdhwumlwM9H
 qoVhl+Wfk3x/VNyQe4SVABQWdxvhVhLnDAiCSgYyh0LV8tuoVBU4/5s52W8OLy6c
 bbJd/UBXDGPg8aBX6UoHup7pPVke2QgFS3g3pO5lz9zlmrfZ8aTMUUWFcwjJFyqH
 fj4W8Mpf8iaNg6PQDzIzhVwT/kpWhtGqZx/FRXfQTN8i4oOf+uS4hSzG/0T8Q9nB
 9uahI68Kjk+Klc39dr+aaLsgE1WPEb6LdzQPNRsA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5aph9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 16:53:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VGfJNJ011136;
 Mon, 31 Aug 2026 16:53:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h6xur-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 16:53:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VGra907603038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 16:53:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D872658052;
 Mon, 31 Aug 2026 16:53:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25DAC58067;
 Mon, 31 Aug 2026 16:53:27 +0000 (GMT)
Received: from [9.43.79.120] (unknown [9.43.79.120])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 16:53:26 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------vgkh5S0L5eVGGklQJDfTKL02"
Message-ID: <67b9ee96-5684-42b8-8e7c-61fed3ed93ce@linux.vnet.ibm.com>
Date: Mon, 31 Aug 2026 22:23:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/9] qtest/phb5: Add testbench for PHB
To: Aditya Gupta <adityag@linux.ibm.com>, Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-2-saif.abrar@linux.ibm.com>
 <ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a95b193 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=PjmdL4u1kqMFsDHB8qsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GEXfVxSDLSK7QMoJF0sA:9 a=66YvoR9EpsYC8bkm:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: yF4BL8tHa4v7XW9-kcIl9QMkUKFhS9AN
X-Proofpoint-ORIG-GUID: UNYdEuXCeiWTVpGUakGF-4NEhWgZWEHV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX4/4lVMlmEGnQ
 DQcXTNJX6XyrGAlkUCseLKSta5b3PINpw68sM23B1bU6ey+osmwfFKKP5BGGhEhuxDTLeHUBM4V
 NDTlWLt9WvVkNa7AyE71IViuclvUGX4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX/Mw3BRmS9vII
 yI56oTVg3a8ImFqdZUdTL7GUF64xoNUeBHmkE5ZGa0DkX0NrlNGdkkxROMKI2HlEcBqMtOdxz+W
 ThdK9SvrvN2bq7yIrueAtX3JsGFE8BT7/Ln0ADRperWabZyutRESP5IUEyFaj+tVTiLVDQunUbB
 HvOPFmzuCdhuyT9B4shAOUidJRxxbMEu62ZoGGJorytj7rerW5f63ELg9nPkrQh0HkvQXO4FAlf
 xl7yxMEddDYWqu9D9MtEmvDcx1w+6Y6e/aYUJ5FRBsIz5M92hFy10ZHtnEDbmEYyIy6G38eiQek
 MMDL6162fCoUiuY4srvh7bWkbYTN/HA3H/b3h1eOHtTORwpmn83AYJbqSWpW0aNTnwjfgbs7NrH
 I0HRg7AU4bh1SsKY++hbp9nxFXYVh0C8PhERoiY/xA1rq3X38csYuaMF6+aZsZbrXlfDOA6NLYQ
 LbADP+/MvPH7KMd23KQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310143
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------vgkh5S0L5eVGGklQJDfTKL02
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 25-06-2026 22:32, Aditya Gupta wrote:
> On 26/06/17 04:50AM, Saif Abrar wrote:
>> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>>
>> New qtest testbench added for PHB[345].
>> Testbench reads PHB Version register and asserts that
>> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
>>
>> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
>> Reviewed-by: Cédric Le Goater<clg@kaod.org>
>> Reviewed-by: Harsh Prateek Bora<harshpb@linux.ibm.com>
>> Reviewed-by: Aditya Gupta<adityag@linux.ibm.com>
>> Reviewed-by: Jishnu Warrier<Jishnu.Warrier@ibm.com>
> Thanks for the patches !


Hello Aditya,

Thanks for your in-depth review!


>
>> <...snip...>
>> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>> +static void phb_version_test(const void *data)
>> +{
>> +    const PnvChip *chip = (PnvChip *)data;
>> +    QTestState *qts;
>> +    const char *machine = "powernv8";
>> +    uint64_t phb_xscom = 0x4809e000;
>> +    uint64_t reg_phb_version = PHB_VERSION;
>> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
>> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
>> +    uint32_t expected_ver = 0xA3;
>> +    uint64_t ver;
>> +
>> +    if (chip->chip_type == PNV_CHIP_POWER9) {
>> +        machine = "powernv9";
>> +        phb_xscom = 0x68084800;
>> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
>> +        indirect_data = PHB_SCOM_HV_IND_DATA;
>> +        reg_phb_version |= PPC_BIT(0);
>> +        expected_ver = 0xA4;
>> +    } else if (chip->chip_type == PNV_CHIP_POWER10) {
>> +        machine = "powernv10";
>> +        phb_xscom = PHB4_XSCOM;
>> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
>> +        indirect_data = PHB_SCOM_HV_IND_DATA;
>> +        reg_phb_version |= PPC_BIT(0);
>> +        expected_ver = 0xA5;
>> +    }
> We are adding PNV_CHIP_POWER11 in qtests in
> https://lore.kernel.org/qemu-devel/20260624195924.1422821-1-adityag@linux.ibm.com/T/#m5ccc85c90fce585b11ec4a89317c21bc6504b10e
>
> fwiw, depending on which series is merged first, we will have to update
> this in future, just keeping a note
>
>> +
>> +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
>> +
>> +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
>> +                                indirect_addr, indirect_data, reg_phb_version);
>> +
>> +    /* PHB Version register bits [24:31] */
>> +    ver = (ver & PPC_BITMASK(24, 31)) >> (63 - 31);
> GETFIELD(PPC_BITMASK(24, 31), ver) ?


Updated with GETFIELD().


>
>> +    g_assert_cmpuint(ver, ==, expected_ver);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +/* Verify versions of all supported PHB's */
>> +static void add_phbX_version_test(void)
>> +{
>> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
>> +        char *tname = g_strdup_printf("pnv-phb/%s",
>> +                                      pnv_chips[i].cpu_model);
>> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
>> +        g_free(tname);
> can use g_autofree:
>      g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
>                                    pnv_chips[i].cpu_model);
>      qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);


Updated with g_autofree.

>
> Thanks,
> - Aditya G
--------------vgkh5S0L5eVGGklQJDfTKL02
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 25-06-2026 22:32, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">On 26/06/17 04:50AM, Saif Abrar wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

New qtest testbench added for PHB[345].
Testbench reads PHB Version register and asserts that
bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Harsh Prateek Bora <a class="moz-txt-link-rfc2396E" href="mailto:harshpb@linux.ibm.com">&lt;harshpb@linux.ibm.com&gt;</a>
Reviewed-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
Reviewed-by: Jishnu Warrier <a class="moz-txt-link-rfc2396E" href="mailto:Jishnu.Warrier@ibm.com">&lt;Jishnu.Warrier@ibm.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks for the patches !</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Hello Aditya, </p>
    <p>Thanks for your in-depth review!</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&lt;...snip...&gt;
+/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
+static void phb_version_test(const void *data)
+{
+    const PnvChip *chip = (PnvChip *)data;
+    QTestState *qts;
+    const char *machine = "powernv8";
+    uint64_t phb_xscom = 0x4809e000;
+    uint64_t reg_phb_version = PHB_VERSION;
+    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
+    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
+    uint32_t expected_ver = 0xA3;
+    uint64_t ver;
+
+    if (chip-&gt;chip_type == PNV_CHIP_POWER9) {
+        machine = "powernv9";
+        phb_xscom = 0x68084800;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA4;
+    } else if (chip-&gt;chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10";
+        phb_xscom = PHB4_XSCOM;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA5;
+    }
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
We are adding PNV_CHIP_POWER11 in qtests in
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20260624195924.1422821-1-adityag@linux.ibm.com/T/#m5ccc85c90fce585b11ec4a89317c21bc6504b10e">https://lore.kernel.org/qemu-devel/20260624195924.1422821-1-adityag@linux.ibm.com/T/#m5ccc85c90fce585b11ec4a89317c21bc6504b10e</a>

fwiw, depending on which series is merged first, we will have to update
this in future, just keeping a note

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip-&gt;cpu_model);
+
+    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
+                                indirect_addr, indirect_data, reg_phb_version);
+
+    /* PHB Version register bits [24:31] */
+    ver = (ver &amp; PPC_BITMASK(24, 31)) &gt;&gt; (63 - 31);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
GETFIELD(PPC_BITMASK(24, 31), ver) ?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Updated with GETFIELD().</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    g_assert_cmpuint(ver, ==, expected_ver);
+
+    qtest_quit(qts);
+}
+
+/* Verify versions of all supported PHB's */
+static void add_phbX_version_test(void)
+{
+    for (int i = 0; i &lt; ARRAY_SIZE(pnv_chips); i++) {
+        char *tname = g_strdup_printf("pnv-phb/%s",
+                                      pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &amp;pnv_chips[i], phb_version_test);
+        g_free(tname);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
can use g_autofree:
    g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
                                  pnv_chips[i].cpu_model);
    qtest_add_data_func(tname, &amp;pnv_chips[i], phb_version_test);</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Updated with <span style="white-space: pre-wrap">g_autofree.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
cite="mid:ajzojholiKw1DkFH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com">
      <pre wrap="" class="moz-quote-pre">

Thanks,
- Aditya G
</pre>
    </blockquote>
  </body>
</html>

--------------vgkh5S0L5eVGGklQJDfTKL02--


