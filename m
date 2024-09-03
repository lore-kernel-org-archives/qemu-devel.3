Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FFDCD342A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 07:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slNVn-0001Nk-5p; Tue, 03 Sep 2024 02:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxingran123456@outlook.com>)
 id 1slNVl-0001NB-KV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:59:33 -0400
Received: from mail-me3aus01olkn2018.outbound.protection.outlook.com
 ([40.92.63.18] helo=AUS01-ME3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxingran123456@outlook.com>)
 id 1slNVj-0006YJ-6j
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:59:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVb5077Wqt4+9twsZ8etVfWQqyLgPUXvY/IffMosXRtpiB13C0WStc+A2ZEvdp3IVsqNAf21dljaKuZOboLOQfuwR+tLwzz9f51bvBCp2rfVXiGfYAoX0aa2oD3iLhoTWeYDN6MYHuEfo8+F2O39AaRq9+OVuFJaOycvKPWiVyHh5mTwdi5eAiPBXSNppWa4F1ln3Av33M1Aikw/257AtESHpmTBO8HP3W8UulVQFQQpWzrKxaGIFwS1bbswECJcff76SA722pKKvEm+pQB80ffeKKUTlKuCPqD0otXRXu73iSSlmhsuugYO3fi6lCaYiw5NmjwhhTgkpcR2TBNXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRnUvuRqgAkrwrc31k8s06osirXrzr4wMMPn63ciTe4=;
 b=BO4T4AbBL/URCmOhKxZcNk/4lqbiph/gO2jhlnKqEIWACWhvseiQ3h4pbS3sl1TLG5E38M3S838Q/QJa51tbJlFX00xmOCQF44xjvvj2V6cDJrwlj9rIZF34kyVtdSI8UDAGf81MoVo5vs13el6IaquRWwaX24kCB9AOwXx7eri7rhEq43D7uiF4754R0gOa7L72E2o6gsjj1MLUmitsEJ3BpfFqwJQwDMKdH0wnZst3fPkfwPXl7Sei7dU3q1aN44iiKVoLbjB0N5LssiN7chPgqS9TPgk1+5mv3dKY4SO+Z3x0/zjsPPjC2S1XYxGE/2ylU6kFPqawcEvNvGaEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRnUvuRqgAkrwrc31k8s06osirXrzr4wMMPn63ciTe4=;
 b=tIkxg8pD8xY17zJSN4dErvlzdXITpb51jPTB8XQTc/d0Pt66pC2W2K6LoJUOyG8P6zZ6HDxMrffEkDgvF7rfgHjErS5Ge+LHcaXyLYn/CFQvdfvwnmJ3KpCUdFVIowCLl/lUj32y3fN1U1EqdJx7cQINnhXEGaY7IrCXJ+tTCWrHeWdmxc56DjCIp796VAh3sfZmwZejTPu3gOSjCWOj2/PrvlCPFHlmzwGk85TMzM3PXTP1XuhvvJm095D00H7CmbrdfnIZFrtyA/FkyabgdGpPQS5LSSgHH+bNw0or3uGd70WIUsbgRyZdpLvU3RsXUBgd6+6Pe3nKwLZLVGkl6A==
Received: from SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:258::8) by
 SY8P282MB5361.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b7::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Tue, 3 Sep 2024 06:53:43 +0000
Received: from SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7a8b:7271:4bc8:e317]) by SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7a8b:7271:4bc8:e317%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 06:53:43 +0000
Message-ID: <SY8P282MB4322B6033550F51C1D42EA64A1932@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
Date: Tue, 3 Sep 2024 14:53:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 <87mskqcp5n.fsf@draig.linaro.org>
 <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org>
 <87seuidjtp.fsf@draig.linaro.org>
 <0635c334-c376-458c-8b8e-787c08f2ffcf@linaro.org>
Content-Language: en-US
From: Xingran Wang <wangxingran123456@outlook.com>
In-Reply-To: <0635c334-c376-458c-8b8e-787c08f2ffcf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [fV1TDpfaXnrMnfymz4oAwzBuAxAbsfG3]
X-ClientProxiedBy: TYCP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::18) To SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:258::8)
X-Microsoft-Original-Message-ID: <17fb9181-dbe2-4ba8-89d8-299f6654a1ea@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY8P282MB4322:EE_|SY8P282MB5361:EE_
X-MS-Office365-Filtering-Correlation-Id: 83118a64-205a-4931-68f2-08dccbe526b5
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|8060799006|19110799003|6090799003|15080799006|440099028|4302099013|3412199025|56899033|1602099012;
X-Microsoft-Antispam-Message-Info: +cn0snodqJMoxHZvGVjDF20FOXLbitBpwbZwXciTQQo6MpdZ7oyT/Tuhxw+PrQKBJUkMIYOJlMuTvkJbD2+R2d90Ug+WxIhGhChxryBuIiZ2TWAh+L59cj+DaycUaEIW7FunJnMwWQA2znFQCMU2gUiwoUStexiPeYuc+WzM4hJzd7ac7SjK3MNy6pBXteblmCjmKDiRUGBwpjRqdw2wwi+5mNg87DW92CGFLhhGT3UafdOLHz9lsqxvrKYTxWIfspEZQ0s/iWZtag+i+1SoseIjwX/bCeCLN4+iP+GvXx2mZI//maQcpeSmuh9h9kDK/QKkhETQGSS60oSd4ZgJYUou83+6WiHkQbFeP2TyfV0AKZNkE5m6jV+FXAL3Ry8Sdie7XUwOIRfXhOPbqJw1qTbUqfMc0ALx+aCnHxVyJHAgUzqpPFU6h/bcZzpsDKiz6+iflz3N33865P7kSiu4p3Sp1UgzwVd+fCUwtKN3zKXylOjdXYkYxjBZMPiYFJ4JrdNXgyVPXNcUudsWj+puJoHFhhsKt6CmHOoi/7a6bvLY4DzEHTCzInu/0qmK9Ws6xfL4qvzo58SAuSwrfrPSo3ogimhygV54tUgCgX8OT2CQugstspdbdZZbzb/13X1WFVps4Eufp/skRvVXMEMHFVKyZ7v4LIFnTjggwgJYpuhclCy5lWbgAbV6sXfUKni4Ubc9xV1J89u0UKuQB80kXu9HqE5HPPEy4bSswXwWHh4S14mVyNylcenOF93WpEvIZYK4odutnIOAwoNGX6MTRKaKl/QFg87+rMpD0S92xxu99ljEryOYHo7qmS/1YckNU2mv6B8m65pSpIYtOYQQUg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJxb2IvS1ZoTXQrODZsaldrVXIzK3lnU1E1S0orbS9Jbm83Vm9PRHVMZXdq?=
 =?utf-8?B?bC9CeTMzWDNoNkJBdlplL3l6NnRzd2wvdy9uOFFKSFZLTC9aNVFDcHZsSEhi?=
 =?utf-8?B?b2FuK2NIUXQ0R2RCczZKRktwNTUrbithNHI3YW9VU1JVSkRaQlBYQ3R2a1o4?=
 =?utf-8?B?TXo4U3hWRk41MTZXUnFwL1AzL2FiaHU1dmRodUo5MGVWRi84MWcxTjgvaGg1?=
 =?utf-8?B?UDM5dzVka3ZCRFd4aVBxZTZNRzVWZUgvamRpbG9EUmFjdVI2MTNNWW1pTnBQ?=
 =?utf-8?B?b3BsbWs1Z1NPNmJCZk5OaksrSU5hY0RON1lRVi9qZ0FsZWRyaEx4SjlRVlo1?=
 =?utf-8?B?U05vcExKUEEwbFVHenhoaTdFSjhHdnhYdXBQa3VTVitlNFpnQ21xWkxrWkx6?=
 =?utf-8?B?TkNFMmJVbW02cTF5Z1N5cEtlSGM4MG9wRDNydW5KVm9FY291QmlNNG1KMms5?=
 =?utf-8?B?NVAxZkgxTVNQVHdRNzZldUpjRE83RUVvQ1Eza2dBN2Uxb01GblhNZ1JtS1RJ?=
 =?utf-8?B?OFdRMDU1OTF4WnNGeGdxb250TjJ2TWtxZUJZaEZaMUVBT1JvbnA0aWN1V3Mx?=
 =?utf-8?B?N3dSRmpsaGJXSStRL2hQVy9LV1dOTGxWT2RjTVNYS2JMRlRxVjFHV2pFai9U?=
 =?utf-8?B?TGJKODJ5dnFkbit0QXd0S1ZhNDh1MzFWMzV1WnA1QW1nYlc1SFlyd0hJN0pt?=
 =?utf-8?B?RkFCY3pkVm81MndOdm4weEJWd2FFQ0FUcEFGL0Rhemh5N2RMOFlyQmR3UEhV?=
 =?utf-8?B?MHlDbk56V0d4eTRqWitMM2Z1ZGUzWWh1TWZMVGp3SXh6OGMxci9ta0hGN1Zs?=
 =?utf-8?B?WFMvS0ZyZCthYVFjS1hZcXZPZmFud0hudzVIV05BbU5kb3B4aDh0aTI5RUZ2?=
 =?utf-8?B?M0I5SG13TVNIU29KK2RDa0VWUm0wRFdRU0dZMllmRkNNS0orWFlzcERZZHJs?=
 =?utf-8?B?TGdsSDFqaVVjS01ZWGN3OWxjdFF3QTZMNy9nUjJtOWZwdzlrb3JjdlRNc2Iz?=
 =?utf-8?B?QitFUWFybWY4TjFYOTdteGwwTFA1OGlIbGUyQko2S0g0eWdUUE1rMks4RXRT?=
 =?utf-8?B?NW8yKzN6bW9NRGlHejFUTEh4UUVZano1Q3A2S1BER21yTGl4VlYweEJqRWNT?=
 =?utf-8?B?WkpNZ3Z5S1lhMmZhcmQ0bHE4NTJOYU92OEJxTEtNWnRxUHkrOVd2ZXg5eWtD?=
 =?utf-8?B?RDY2aHFxUmhWaFVrUGsyUW13RDdqOVA3L1JGYUxGY0NQODdxSWN4L2VKK2RL?=
 =?utf-8?B?cFJBU3F4ZW10elBnaHFPMzhjeGswNXJWNnlkWTN6NTJvRC9XcEs3Tm5hS2N6?=
 =?utf-8?B?WjRkT0ZNRmtXY1NxSjNkQml1VmNWZGNFR29XUlgrSVFwUGd5eElDSHIydGRx?=
 =?utf-8?B?c1hNOVBrYlB4ekRrSG4vd0JUb3hoTEFtUW5rL1FjOFRWOXg1S2owY1EzZGUv?=
 =?utf-8?B?Z216dW9iZXFKU05NT0xMR1NpaUtMOGsrWjJVU1F3bFJ3TDF0a1FGWlZpOXJW?=
 =?utf-8?B?OS9yb09BQ0RrR1dRYkxydzdramQyelVEMDFwekIyblIwR255WTBBM2RSSEVW?=
 =?utf-8?B?ZGlIdkVuNVJFN29YNnJVOVZpdnIrSUZlYkxReHhrUlQ5Y0Vmak9INU82cUdo?=
 =?utf-8?B?QVpqMmc5RVg2anR4cUJuSXNndFhyUzJvRFY1MlI2RUJSbHQyUU5LdDV4OUdS?=
 =?utf-8?Q?n8UAt8D48a2TJhHn3Zd7?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83118a64-205a-4931-68f2-08dccbe526b5
X-MS-Exchange-CrossTenant-AuthSource: SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 06:53:43.8965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5361
Received-SPF: pass client-ip=40.92.63.18;
 envelope-from=wangxingran123456@outlook.com;
 helo=AUS01-ME3-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Before seeing Alex's suggestion, I didn't realize that we could use the 
existing injection mechanism to enable plugins to count instructions 
accurately.

Now, I also agree that the new API introduced by this patch for the 
plugin subsystem could make the plugin API overly complex.


Many thanks to Alex and Pierrick for the timely review and helpful comments.



On 9/3/24 2:56 AM, Pierrick Bouvier wrote:
> On 9/2/24 10:52, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>
>>> Hi Xingran,
>>>
>>> On 9/2/24 03:42, Alex Bennée wrote:
>>>> Xingran Wang <wangxingran123456@outlook.com> writes:
>>>>
>>>>> Currently, the instruction count obtained by plugins using the 
>>>>> translation
>>>>> block execution callback is larger than the actual value. Adding 
>>>>> callbacks
>>>>> in cpu_restore_state_from_tb() and cpu_io_recompile() allows 
>>>>> plugins to
>>>>> correct the instruction count when exiting a translation block
>>>>> mid-execution, properly subtracting the excess unexecuted
>>>>> instructions.
>>>> This smells like exposing two much of the TCG internals to the
>>>> plugin
>>>> mechanism. You can already detect when we don't reach the end of a 
>>>> block
>>>> of instructions by instrumentation as I did in:
>>>>
>>>
>>> I agree that this is definitely a QEMU implementation "detail", and
>>> should not be a concern for end users.
>>>
>>> The documentation already warns that all instructions may not execute,
>>> and that in this case, it's better to instrument them directly,
>>> instead of TB:
>>> https://www.qemu.org/docs/master/devel/tcg-plugins.html#translation-blocks. 
>>>
>>>
>>> Finally, even if we integrated an API like what you propose in this
>>> patch, I think it would be very easy for plugins writers to make a
>>> mistake using it, as you need to keep track of everything yourself.
>>>
>>> If we want to stay on the topic of this patch, one direction that
>>> would be better in my opinion is a "after_tb_exec" API, where the TB
>>> passed in parameter is guaranteed to have all its instructions that
>>> were executed (not interrupted).
>>
>> Or indeed resolves with the current PC at the "end" of the TB where it
>> gets to. QEMU could keep track of that easily enough as the recompile
>> and bus fault paths are slow paths anyway. It would be tricky to support
>> inline for that though.
>>
>> As TB is exposed internally I think we'd just need to set a flag and
>> call out. Maybe an API like:
>>
>>    /**
>>     * typedef qemu_plugin_vcpu_tb_end_cb_t - vcpu callback at end of 
>> block
>>     * @vcpu_index: the current vcpu context
>>     * @pc: the next PC
>>     * @insns: instructions executed in block
>>     * @userdata: a pointer to some user data supplied when the callback
>>     * was registered.
>>     */
>>    typedef void (*qemu_plugin_vcpu_tb_end_cb_t)(unsigned int vcpu_index,
>>                                                 uint64_t next_pc,
>>                                                 size_t n_insns,
>>                                                 void *userdata);
>>
>>    /**
>>     * qemu_plugin_register_vcpu_tb_exec_end_cb() - register execution 
>> callback at end of TB
>>     * @tb: the opaque qemu_plugin_tb handle for the translation
>>     * @cb: callback function
>>     * @flags: does the plugin read or write the CPU's registers?
>>     * @userdata: any plugin data to pass to the @cb?
>>     *
>>     * The @cb function is called every time a translated unit executes.
>>     */
>>    QEMU_PLUGIN_API
>>    void qemu_plugin_register_vcpu_tb_exec_end_cb(struct 
>> qemu_plugin_tb *tb,
>> qemu_plugin_vcpu_tb_end_cb_t cb,
>>                                                   enum 
>> qemu_plugin_cb_flags flags,
>>                                                   void *userdata);
>>
>
> Something like this, yes.
> I still think it makes the whole API too complex, and would confuse 
> users. If plugins writers need "instruction accurate" instrumentation, 
> there are already functions for that.
> And if the only use case is to identify control flow changes, then we 
> could create a dedicated API for this.
>

The API that Alex proposed looks great and could replace the two event 
callbacks introduced in this patch.
I also agree with Pierrick that the existing instrumentation mechanism 
already allows users to achieve instruction-accurate instrumentation.
It would be even better if this API didn't rely on inserting TCG 
instructions before every instruction in the TB, as this would offer 
better performance compared to the original implementation for 
identifying control flow changes.

> I wonder what is the original use case of Xingran. Any chance you 
> could share with us why this is needed, and why existing functions are 
> not enough?

Summary:

In retrospect, these two event callbacks don't serve a general purpose 
and can be replaced by the existing injection mechanism, which indeed 
makes the API confusing and complex.

Detail:


We (myself and the XiangShan team) attempted to implement the "SimPoint" 
method using QEMU's plugin system and to accelerate RISCV CPU core 
performance simulation with "SimPoint Checkpoint" and QEMU.

The first step of "SimPoint" is to profile the frequency of executed 
code to create code signatures representing the program's behavior at 
different execution points.
This requires an accurate instruction count, which can be instrumented 
by the plugin.

I used a simple bare-metal program to verify that the instruction count 
instrumented by the plugin matched the actual value.
However, I discovered that TCG would prematurely exit the currently 
executing TB when encountering an MMIO instruction or an exception 
without notifying the count plugin, resulting in the instruction count 
higher than the actual value.
As a QEMU novice, a straightforward solution for me was to have TCG 
notify the plugin whenever a TB is exited prematurely during 
execution.This is the role of the event callback in 
cpu_restore_state_from_tb().
The event callback in cpu_io_recompile(), on the other hand, was added 
as a workaround because the recompiled TB only allows memory 
instrumentation, making the instruction count for this short TB 
undetectable by the plugin.

>
>> I think the tricky bit would be getting TCG to emit the callback code
>> for the last instruction before the
>> tcg_gen_exit_tb/tcg_gen_lookup_and_goto_ptr bits but after whatever else
>> it has done to execute the instruction.
>>
>> I don't think we could easily support inline ops at tb end though.
>>
>> Richard,
>>
>> What do you think?
>>
>>
>>>>     Message-Id: <20240718145958.1315270-1-alex.bennee@linaro.org>
>>>>     Date: Thu, 18 Jul 2024 15:59:58 +0100
>>>>     Subject: [RFC PATCH v3] contrib/plugins: control flow plugin
>>>>     From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
>>>> So what exactly are we trying to achieve here? A more efficient
>>>> detection of short blocks?
>>>>
>>>>>
>>>>> Signed-off-by: Xingran Wang <wangxingran123456@outlook.com>
>>>>> ---
>>>>>    accel/tcg/translate-all.c    |  27 ++++++++
>>>>>    include/qemu/plugin-event.h  |   2 +
>>>>>    include/qemu/plugin.h        |  24 +++++++
>>>>>    include/qemu/qemu-plugin.h   | 131 
>>>>> +++++++++++++++++++++++++++++++++++
>>>>>    plugins/api.c                |  78 +++++++++++++++++++++
>>>>>    plugins/core.c               |  42 +++++++++++
>>>>>    plugins/qemu-plugins.symbols |  10 +++
>>>>>    tests/tcg/plugins/bb.c       |  25 +++++++
>>>>>    8 files changed, 339 insertions(+)
>>>>>
>>>>> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>>>> index fdf6d8ac19..642f684372 100644
>>>>> --- a/accel/tcg/translate-all.c
>>>>> +++ b/accel/tcg/translate-all.c
>>>>> @@ -65,6 +65,7 @@
>>>>>    #include "internal-target.h"
>>>>>    #include "tcg/perf.h"
>>>>>    #include "tcg/insn-start-words.h"
>>>>> +#include "qemu/plugin.h"
>>>>>      TBContext tb_ctx;
>>>>>    @@ -218,6 +219,19 @@ void cpu_restore_state_from_tb(CPUState
>>>>> *cpu, TranslationBlock *tb,
>>>>>            cpu->neg.icount_decr.u16.low += insns_left;
>>>>>        }
>>>>>    +#ifdef CONFIG_PLUGIN
>>>>> +    /*
>>>>> +     * Notify the plugin with the relevant information
>>>>> +     * when restoring the execution state of a TB.
>>>>> +     */
>>>>> +    struct qemu_plugin_tb_restore ptb_restore;
>>>>> +    ptb_restore.cpu_index = cpu->cpu_index;
>>>>> +    ptb_restore.insns_left = insns_left;
>>>>> +    ptb_restore.tb_n = tb->icount;
>>>>> +    ptb_restore.tb_pc = tb->pc;
>>>>> +    qemu_plugin_tb_restore_cb(cpu, &ptb_restore);
>>>>> +#endif
>>>>> +
>>>> See also the unwind patches which is a more generic approach to
>>>> ensuring
>>>> "special" registers are synced at midpoint when using the register 
>>>> API:
>>>>     Message-Id: <20240606032926.83599-1-richard.henderson@linaro.org>
>>>>     Date: Wed,  5 Jun 2024 20:29:17 -0700
>>>>     Subject: [PATCH v2 0/9] plugins: Use unwind info for special 
>>>> gdb registers
>>>>     From: Richard Henderson <richard.henderson@linaro.org>
>>>> <snip>
>>>>
>>>
>>> Thanks,
>>> Pierrick
>>


